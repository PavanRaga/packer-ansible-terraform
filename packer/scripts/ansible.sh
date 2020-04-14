#!/bin/bash

# Install Ansible repository.
sudo apt -y update && apt-get -y upgrade
sudo apt -y install software-properties-common
sudo apt-add-repository ppa:ansible/ansible

#Install Python and pip
sudo apt-get -qq install python -y
sudo apt-get -y update
sudo apt-get install python-pip -y

# Install Ansible.
sudo apt -y update
sudo apt -y install ansible