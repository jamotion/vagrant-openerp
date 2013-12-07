# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "raring32"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-i386-vagrant-disk1.box"
  
  config.vm.network :forwarded_port, guest: 5432, host: 5432 #postgresql
  config.vm.network :forwarded_port, guest: 8069, host: 8069 #openerp webui
  config.vm.network :forwarded_port, guest: 8070, host: 8070 #openerp xml-rpc

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "default.pp"
  end
end
