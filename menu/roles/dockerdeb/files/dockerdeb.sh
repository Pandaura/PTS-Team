#!/bin/bash

echo "Update System"
sudo apt-get update -yqq

echo "Install common packages"
sudo apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common -yqq

echo "Add Docker’s official GPG key:"
sudo curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

echo "Verify  GPG key"
sudo apt-key fingerprint 0EBFCD88 -yqq

echo "Docker Install Base packages"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

echo "Update again"
sudo apt-get update -yqq

echo "Docker install full packages"
 sudo apt-get install docker-ce docker-ce-cli containerd.io -yqq

exit 0
