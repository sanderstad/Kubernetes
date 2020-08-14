#!/bin/bash

# Colors
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)
#echo "${red}Failure.${reset}"

echo "${green}##########################################################################${reset}"
echo "${green}## Installing wget                                                       #${reset}"
echo "${green}##########################################################################${reset}"
sudo apt-get update
sudo apt-get install -y git wget

# Install Docker
echo "${green}##########################################################################${reset}"
echo "${green}# Installing docker                                                      #${reset}"
echo "${green}##########################################################################${reset}"
echo ""
echo "${green} - Install prerequisites${reset}"
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

echo "${green} - Install certificate${reset}"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "${green} - Adding fingerprint${reset}"
sudo apt-key fingerprint 0EBFCD88

echo "${green} - Add repository${reset}"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo "${green} - Updating repositories${reset}"
sudo apt-get update

echo "${green} - Install docker${reset}"
sudo apt-get install -yq docker-ce

# Install kubernetes
echo "${green}##########################################################################${reset}"
echo "${green}# Installing kubernetes                                                  #${reset}"
echo "${green}##########################################################################${reset}"
echo ""
echo "${green} - Add certificate${reset}"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "${green} - Create sources list file${reset}"
sudo touch /etc/apt/sources.list.d/kubernetes.list
echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' | sudo tee /etc/apt/sources.list.d/kubernetes.list

echo "${green} - Update repositories${reset}"
sudo apt-get update -y

echo "${green} - Install kubernetes${reset}"
sudo apt-get install -y  kubelet kubeadm kubectl kubernetes-cni nfs-common

echo "${green} - Set containers networks${reset}"
sudo sysctl net.bridge.bridge-nf-call-iptables=1

echo "${green} - Disable swap${reset}"
sudo swapoff -a

echo "${green} - Install common nfs packages${reset}"
sudo apt-get install nfs-common -y

echo "${green} - Cleanup${reset}"
sudo rm -rf /var/lib/kubelet/*