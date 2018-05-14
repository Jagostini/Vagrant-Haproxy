#!/bin/bash

if [ ! -f /etc/network/if-up.d/custom-network-config ]; then

  #Update
  sudo apt-get update

   #Installer Apache
  sudo apt-get -y install apache2

   #Installer PHP
  sudo apt-get -y install php5 libapache2-mod-php5 php5-mcrypt

  #On renome le fichier .html en .php
  mv /var/www/html/index.html /var/www/html/index.php

  cat > /var/www/html/index.php <<EOD
<html>
  <head>
    <title><?php echo gethostname(); ?></title>
  </head>
  <body>
    <h1><?php echo gethostname(); ?></h1>
    <?php 
      echo "message test";
    ?>
  </body>
</html>
EOD

  # Log the X-Forwarded-For
  perl -pi -e  's/^LogFormat "\%h (.* combined)$/LogFormat "%h %{X-Forwarded-For}i $1/' /etc/apache2/apache2.conf
  /usr/sbin/service apache2 restart

fi