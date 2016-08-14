# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  # config.vm.define "arch" do |arch|
  #   arch.vm.box = "terrywang/archlinux"
  # end

  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "ubuntu/xenial64"
  end

  # config.vm.define "osx" do |osx|
  #   osx.vm.box = "osx"
  # end

  # install virtualbox-guest-utils until xenial box is patched
  # config.vm.synced_folder ".", "/vagrant", disabled: false
  # config.vm.provision "shell",
  #                     inline: "sudo apt-get --no-install-recommends install virtualbox-guest-utils"
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
