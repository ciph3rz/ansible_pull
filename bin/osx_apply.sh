#!/usr/bin/env sh

ansible-playbook -i "localhost," -c local osx.yml --ask-become-pass
