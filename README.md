# Vagrant-Haproxy

http://localhost:8080/haproxy?stats : Interface admin du HAProxy
http://localhost:8081/ : interface load balanced interface des deux servers web. 

Terminal 1
  - lancer serveur HAProxy : vagrant up haproxy
  - se connecter à HAProxy : vagrant ssh

Terminal 2
  - lancer serveur web1 : vagrant up web1
  - se connecter à web1 : vagrant ssh

Terminal 3
  - lancer serveur web2 : vagrant up web2
  - se connecter à web2 : vagrant ssh
  
------------------------------------------------------------------------

--> Déclare la configuration de ressource de toutes les VMs

```
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", 512, "--cpus", 1]
  end
```

--> Déclare la configuration de la VM de HAproxy \
        - Déclaration du hostname \
        - Déclaration des ports d'écoute \
        - Déclaration de la configuration réseau \
        - Lancement des spécificitées avec le fichier "haproxy-setup.sh"

```
config.vm.define :haproxy, primary: true do |haproxy_config|
    haproxy_config.vm.hostname = 'haproxy'
    haproxy_config.vm.network :forwarded_port, guest: 8080, host: 8080
    haproxy_config.vm.network :forwarded_port, guest: 80, host: 8081

    haproxy_config.vm.network :private_network, ip: "192.168.33.10", netmask: "255.255.255.0"
    haproxy_config.vm.provision :shell, :path => "haproxy-setup.sh"
  end
```

--> Déclare la configuration de la VM web1 \
        - Déclaration du hostname \
        - Déclaration du dossier de synchronisation "Attention chemin à modifier selon emplacement"\
        - Déclaration de la configuration réseau \
        - Lancement des spécificitées avec le fichier "web-setup.sh"

```
  config.vm.define :web1, second: true do |web1_config|
    web1_config.vm.hostname = 'web1'
    web1_config.vm.synced_folder "/Documents/GitHub/Vagrant-Haproxy/data_web", "/var/www/" 
    #Attention chemin à modifier selon emplacement
    
    web1_config.vm.network :private_network, ip: "172.28.33.11", netmask: "255.255.255.0"
    web1_config.vm.provision :shell, :path => "web-setup.sh"
  end
```

--> Déclare la configuration de la VM web2 \
        - Déclaration du hostname \
        - Déclaration du dossier de synchronisation "Attention chemin à modifier selon emplacement"\
        - Déclaration de la configuration réseau \
        - Lancement des spécificitées avec le fichier "web-setup.sh"
        
```
  config.vm.define :web2, third: true do |web2_config|
    web2_config.vm.hostname = 'web2'
    web2_config.vm.synced_folder "/Documents/GitHub/Vagrant-Haproxy/data_web", "/var/www/" 
    #Attention chemin à modifier selon emplacement
    
    web2_config.vm.network :private_network, ip: "172.28.33.12", netmask: "255.255.255.0"
    web2_config.vm.provision :shell, :path => "web-setup.sh"
  end
```





