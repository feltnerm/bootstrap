# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # config.vm.define "arch" do |arch|
  #   arch.vm.box = "terrywang/archlinux"
  # end

  config.vm.define "osx" do |osx|
    osx.vm.box = "osx"
    # Use NFS for the shared folder
    # osx.vm.network "private_network", type: "dhcp"
    osx.vm.network "private_network", ip: "192.168.50.4"
    osx.vm.synced_folder ".", "/vagrant",
                         id: "vagrant-root",
                         :nfs => true,
                         :mount_options => ['nolock,vers=3,udp,noatime']
  end

  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "ubuntu/bionic64"
    ubuntu.vm.box = "ubuntu/cosmic64"
    # install virtualbox-guest-utils until xenial box is patched
    ubuntu.vm.provision "shell",
                        inline: "sudo apt-get --no-install-recommends install virtualbox-guest-utils"
    ubuntu.vm.synced_folder ".", "/vagrant", disabled: false
  end

  config.vm.define "archlinux" do |archlinux|
    archlinux.vm.box = "archlinux/archlinux"
    archlinux.vm.synced_folder ".", "/vagrant", disabled: false
  config.vm.define "arch" do |arch|
      arch.vm.box = "archlinux/archlinux"
      arch.vm.synced_folder ".", "/vagrant", disabled: false
  end

  config.vm.provision "shell",
    path: "bootstrap.sh",
    env: {
      "BOOTSTRAP_USER" => "mark",
      "BOOTSTRAP_ROOT" => "/vagrant/"
    }

# config.vm.provision "ansible_local" do |ansible|
#   # ansible.install = true
#   # ansible.limit = "all"
  #   # ansible.inventory_path = "environments/local"
  #   ansible.playbook = "bootstrap.yml"
  # end


end
