#!/bin/bash

# Install other dev utilities
# Download and install VSCode, Termius and Google Chrome
echo "Download and install VSCode, Termius and Google Chrome"
wget https://www.termius.com/download/linux/Termius.deb
wget -O vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i *.deb 

# Install aws-cli
echo "Install aws-cli"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install Terraform
echo "Install Terraform"
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

# Install Ansible
echo "Install Ansible"
sudo apt update
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
sudo apt install terminator -y

# Finish installing Terraform, pyhton3-pip and Terminator
echo "Finish installing Terraform, pyhton3-pip and Terminator"
sudo apt-get install terraform python3-pip terminator -y
touch ~/.bashrc
terraform -install-autocomplete

# Install Ansible-lint
echo "Install Ansible-lint"
pip3 install ansible-lint

# Add ansible-lint to PATH
echo "\n export PATH=$PATH:/home/ubuntu/.local/bin" >> /home/ubuntu/.bashrc
source /home/ubuntu/.bashrc

# Cleanup: Delete all .deb files
echo "Delete all .deb files and aws zip file"
rm *.deb awscliv2.zip

# Reboot the system
sudo reboot