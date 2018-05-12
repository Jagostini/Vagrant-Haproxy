# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.box_url = "https://vagrantcloud.com/hashicorp/precise64"
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", 512, "--cpus", 1]
  end
  #config.vm.synced_folder ".", "/vagrant"

  config.vm.define :haproxy, primary: true do |haproxy_config|
    haproxy_config.vm.hostname = 'haproxy'
    haproxy_config.vm.network :forwarded_port, guest: 8080, host: 8080
    haproxy_config.vm.network :forwarded_port, guest: 80, host: 8081

    haproxy_config.vm.network :private_network, ip: "192.168.33.10", netmask: "255.255.255.0"
    haproxy_config.vm.provision :shell, :path => "haproxy-setup.sh"
  end

  config.vm.define :web1, second: true do |web1_config|
    web1_config.vm.hostname = 'web1'
    web1_config.vm.network :private_network, ip: "172.28.33.11", netmask: "255.255.255.0"
    web1_config.vm.provision :shell, :path => "web-setup.sh"
  end

  config.vm.define :web2, third: true do |web2_config|
    web2_config.vm.hostname = 'web2'
    web2_config.vm.network :private_network, ip: "172.28.33.12", netmask: "255.255.255.0"
    web2_config.vm.provision :shell, :path => "web-setup.sh"
  end
end