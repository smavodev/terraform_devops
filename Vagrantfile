# -*- mode: ruby -*-
# vi: set ft=ruby :

# ========================
# 📦 VARIABLES CONFIGURABLES
# ========================
# Puedes modificar estas variables directamente aquí o pasarlas como variables de entorno
user_name      = ENV['VM_USER']        || "smavodev"
user_ip        = ENV['VM_IP']          || "192.168.56.253"
vm_box         = ENV['VM_BOX']         || "ubuntu/jammy64"  # "bento/ubuntu-24.04"
vm_version     = ENV['VM_VERSION']     || "20241002.0.0" #  "202502.21.0"

vm_name        = ENV['VM_NAME']        || "devops-terraform"
shared_folder  = ENV['SHARED_FOLDER']  || "/home/vagrant/shared"
scripts_folder = ENV['SHARED_FOLDER']  || "/home/vagrant/Scripts"
ansible_folder = ENV['ANSIBLE_FOLDER']  || "/home/vagrant/ansible"

ram_mb        = ENV['VM_MEMORY']      || "4096"
cpu_count     = ENV['VM_CPUS']        || "2"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = vm_box
  config.vm.box_version = vm_version

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # Puerto para acceder desde el host
  config.vm.network "private_network", ip: user_ip
#   config.vm.network "forwarded_port", guest: 8080, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Disable the default share of the current code directory. Doing this
  # provides improved isolation between the vagrant box and your host
  # by making sure your Vagrantfile isn't accessible to the vagrant box.
  # If you use this you may want to enable additional shared subfolders as
  # shown above.
  # config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./shared", shared_folder
  config.vm.synced_folder "./Scripts", scripts_folder
  config.vm.synced_folder "./ansible", ansible_folder

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
    vb.name = vm_name
    vb.memory = ram_mb
    vb.cpus = cpu_count
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL

  # 🛠 Provisionamiento modular
#   config.vm.provision "shell", path: "Scripts/create_user.sh", args: [user_name, shared_folder, user_ip], privileged: true
#   config.vm.provision "shell", path: "Scripts/setup_ansible.sh", args: [user_name, user_ip], privileged: true
  config.vm.provision "shell", path: "Scripts/setup_docker_y_compose.sh", privileged: true
  config.vm.provision "shell", path: "Scripts/setup_terraform.sh", privileged: true

  config.vm.provision "shell", inline: <<-SHELL
    echo "✅ Provisionamiento completado con éxito. Entorno de desarrollo: http://#{user_ip} despliegue de vagrant completado"
  SHELL

## ⬇️ Solo activa esta parte después del primer `vagrant up` exitoso
## cuando el usuario `smavodev` ya existe y tiene clave pública autorizada
#   config.ssh.username = user_name
#   config.ssh.private_key_path = "./shared/id_rsa"
#   config.ssh.shell = "/bin/bash"

end
