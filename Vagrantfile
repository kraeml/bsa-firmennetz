# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.8.5"

#required_plugins = %w(vagrant-hostsupdater vagrant-vbguest)

#plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
#if not plugins_to_install.empty?
#  puts "Installing plugins: #{plugins_to_install.join(' ')}"
#  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
#    exec "vagrant #{ARGV.join(' ')}"
#  else
#    abort "Installation of one or more plugins has failed. Aborting."
#  end
#end

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # vbguest-plugin installed? https://github.com/dotless-de/vagrant-vbguest
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end
  config.vm.box = "kraeml/xenial-64-de"

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
    # Customize the amount of memory,cpu on the VM:
    vb.memory = "1024"
    vb.customize ["modifyvm", :id, "--cpus", 2]
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "75"]

    vb.linked_clone = true
  end

  config.vm.define "pc1" do |pc1|
    pc1.vm.network :public_network,
                      bridge: ["enp3s0","eth0"],
                      ip: "192.168.56.69"
    pc1.vm.network :private_network,
                      ip: "192.168.109.2",
                      mac: "0800272d6012",
                      virtualbox__intnet: "rot",
                      auto_config: false
    #pc1.vm.hostname = "pc1"
    pc1.vm.provider "virtualbox" do |vb|
      vb.name = "pc1"
    end
    #pc1.vm.provision "shell", path: "pc1_skript-isc-dhcp-server-block-2network.sh"
    #pc1.vm.provision "shell", path: "pc1_skript-bind9.sh"
  end

  config.vm.define "pc2" do |pc2|
    pc2.vm.network :private_network,
                      ip: "192.168.109.3",
                      mac: "0800272d6022",
                      virtualbox__intnet: "rot",
                      auto_config: false
    #pc2.vm.hostname = "pc2"
    pc2.vm.provider "virtualbox" do |vb|
      vb.name = "pc2"
    end
    #pc2.vm.provision "shell", path: "pc2_skript-einfach.sh"
  end
  config.vm.define "pc3" do |pc3|
    pc3.vm.network :private_network,
                      ip: "192.168.109.4",
                      mac: "0800272d6032",
                      virtualbox__intnet: "rot",
                      auto_config: false
    #pc3.vm.hostname = "pc3"
    pc3.vm.provider "virtualbox" do |vb|
      vb.name = "pc3"
    end
    #pc3.vm.provision "shell", path: "pc3_skript-einfach.sh"
  end
  config.vm.define "pc4" do |pc4|
    pc4.vm.network :private_network,
                      ip: "192.168.109.5",
                      mac: "0800272d6042",
                      virtualbox__intnet: "rot",
                      auto_config: false
    #pc4.vm.hostname = "pc4"
    pc4.vm.provider "virtualbox" do |vb|
      vb.name = "pc4"
    end
    #pc4.vm.provision "shell", path: "pc4_skript-einfach.sh"
  end
end
