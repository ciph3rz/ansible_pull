#!/usr/bin/env bash
. /etc/os-release

GHREPO=https://github.com/ciph3rz/ansible_pull.git
CODEREPO=$HOME/code
LOCALREPO=$CODEREPO/ansible_pull
LOCALREPO_VC_DIR=$LOCALREPO/.git

printf "Bootstrap Script\n"

printf "Which Ansible Play would you like to run?\n"
printf "For example core, desktop, kali or vps?\n "
printf "\n "

read -r play

printf "Ensure Code Repo exists prior to running script\n"
printf "\n "

if [ ! -d $CODEREPO ]
then
    mkdir -p $CODEREPO
fi


mkdir -p $CODEREPO
cd $CODEREPO

printf "Installing pre-requisites\n"
printf "\n "

if [[ $ID = "ubuntu" || $ID = "pop" ]]; then

    sudo apt install git curl wget ansible

elif [[ $ID = "fedora" ]]; then
    sudo dnf install git curl wget ansible util-linux-user
else
    ID_Uknown=1
fi

printf "Cloning Ansible Library\n"
printf "\n "
# if [ -d $LOCALREPO ]; then
#     git pull https://github.com/ciph3rz/ansible_pull.git
# else
#     git clone https://github.com/ciph3rz/ansible_pull.git
# fi
if [ ! -d $LOCALREPO_VC_DIR ]
then
    git clone $GHREPO $LOCALREPO
else
    cd $LOCALREPO
    git pull $GHREPO
fi

cd $LOCALREPO

printf "Running Ansible Playbook $play \n"
printf "\n "
ansible-playbook $play.yml --ask-become-pass
