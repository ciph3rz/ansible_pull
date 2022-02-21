#!/usr/bin/env bash


printf "Bootstrap Script\n"

printf "Which Ansible Play would you like to run?\n"
printf "For example core, desktop, kali or vps?\n "

read -r play

mkdir -p $HOME/code
cd $HOME/code

printf "Installing pre-requisites\n"

sudo apt install git curl wget ansible

printf "Cloning Ansible Library\n"
git clone https://github.com/ciph3rz/ansible_pull.git

cd $HOME/code/ansible_pull

printf "Running Ansible Playbook $play \n"
ansible-playbook $play.yml --ask-become-pass
