# -*- mode: ruby -*-
# vi: set ft=ruby :

ELK_BOX = 'elk'

Vagrant.configure('2') do |config|
  config.vm.define :elk do |elk|
    elk_ip = '11.0.1.7'
    elk.vm.provider :virtualbox do |vb|
      vb.name = "elk_workshop"
      vb.customize ['modifyvm', :id, '--memory', '2048']
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
    elk.vm.box = ELK_BOX
    elk.vm.network :private_network, ip: elk_ip
    elk.vm.hostname = 'elk'
    # elk.vm.synced_folder "resources", "/home/vagrant/resources", create: true
  end
end