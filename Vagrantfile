# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "precise32"
    config.vm.box_url = "http://files.vagrantup.com/precise32.box"


    config.vm.network :forwarded_port, guest: 5432, host: 5432 #postgresql
    config.vm.network :forwarded_port, guest: 8068, host: 8068 #openerp restful api
    config.vm.network :forwarded_port, guest: 8069, host: 8069 #openerp xml-rpc

    #config.vm.host_name = "vagrant.example.com"

    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "puppet/manifests"
        puppet.manifest_file  = "vagrant.pp"
    end
end
