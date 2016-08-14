#!/usr/bin/env bash

echo "Bootstrappin' a new system!"

function arch() {
    hash pacman &>/dev/null || (echo 'pacman is missing.' && exit)
    sudo pacman -Syyu --noconfirm
    local INSTALL_COMMAND='sudo pacman -Syy --noconfirm'
    $INSTALL_COMMAND git python python2 python-pip python2-pip
    sudo pip install pip --upgrade
    sudo pip2 install pip --upgrade
    sudo pip2 install ansible==1.9.2
}

function ubuntu() {
    hash apt-get &>/dev/null || (echo 'apt-get is missing.' && exit)
    sudo apt-get update
    sudo apt-get -y upgrade
    local INSTALL_COMMAND='sudo apt-get -y install'
    $INSTALL_COMMAND build-essential git python python-dev python-pip ansible
    sudo pip install pip --upgrade
}

function brew_for_multiple_users() {
    sudo chgrp -R admin /usr/local
    sudo chmod -R g+w /usr/local
    sudo chgrp -R admin /Library/Caches/Homebrew
    sudo chmod -R g+w /Library/Caches/Homebrew
}

function osx() {
    xcode-select --install
    hash brew &>/dev/null && echo "brew found" || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew_for_multiple_users
    brew doctor
    brew update
    brew install git
    brew install python --framework --with-brewed-openssl
    sudo easy_install pip
    brew install ansible
}

while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
case $(uname) in
    'Darwin')
        osx
        ;;
    'Linux')
        case $(lsb_release -si) in
            'Ubuntu')
                ubuntu
                ;;
            *)
                arch
                ;;
            esac
esac

echo "## pwd"
pwd
echo "## pwd"

ansible-playbook -i environments/local bootstrap.yml
