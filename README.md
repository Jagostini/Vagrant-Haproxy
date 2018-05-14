# Vagrant-Haproxy

Open up http://localhost:8080/haproxy?stats in your host's browser. This is the HAProxy admin interface.
Open up http://localhost:8081/ in your host's browser. This is the load balanced interface to the two web servers. 

Terminal 1
  lancer serveur HAProxy : vagrant up haproxy
  se connecter à HAProxy : vagrant ssh

Terminal 2
  "        "        web1 : vagrant up web1
  "        "        web1 : vagrant ssh

Terminal 3
  "        "        web2 : vagrant up web2
  "        "        web2 : vagrant ssh

MaJ futur :
- ajout du mode Rsync pour synchroniser les modifications sur les deux serveurs
