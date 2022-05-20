#!/usr/bin/env bash
. /etc/os-release

printf "Bootstrap Script\n"

printf "Which Ansible Play would you like to run?\n"
printf "For example core, desktop, kali or vps?\n "

read -r play

mkdir -p $HOME/code
cd $HOME/code

printf "Installing pre-requisites\n"

if  [[ $ID = "ubuntu" ]]; then

    sudo apt install git curl wget ansible

elif [[ $ID = "fedora" ]]; then
    sudo dnf install git curl wget ansible util-linux-user
else
    ID_Uknown=1
fi

printf "Cloning Ansible Library\n"
if [ -f $HOME/code/ansible_pull ]; then
    git pull https://github.com/ciph3rz/ansible_pull.git
else
    git clone https://github.com/ciph3rz/ansible_pull.git
fi

cd $HOME/code/ansible_pull

printf "Running Ansible Playbook $play \n"
ansible-playbook $play.yml --ask-become-pass
