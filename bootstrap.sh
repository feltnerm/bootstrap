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
    brew install caskroom/cask/brew-cask
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

PROCEED=""
if [[ -z "$BOOTSTRAP_USER" ]]; then
    read -r -p "BOOTSTRAP_USER not found. Ok to proceed as $USER ?? [y/N] " \
         PROCEED
    while true; do
        case "$PROCEED" in
            'y')
                BOOTSTRAP_USER="$USER"
                break
                ;;
            'Y')
              BOOTSTRAP_USER="$USER"
              break
              ;;
            'n')
              read -r -p "Enter username to bootstrap: " BOOTSTRAP_USER
              break
              ;;
            'N')
                read -r -p "Enter username to bootstrap: " BOOTSTRAP_USER
                break
                ;;
            *)
              read -r -p "BOOTSTRAP_USER not found. Ok to proceed as $USER ?? [y/N] " \
                   PROCEED
                ;;
        esac
    done
fi

[[ -z "$BOOTSTRAP_ROOT" ]] && BOOTSTRAP_ROOT="./"
echo ">> Bootstrap root: '$BOOTSTRAP_ROOT'"
echo ">> Ansible variable set: 'user: $BOOTSTRAP_USER'"
ansible-playbook \
    -e "user=$BOOTSTRAP_USER" \
    -i "$BOOTSTRAP_ROOT"environments/local \
    "$BOOTSTRAP_ROOT"bootstrap.yml
