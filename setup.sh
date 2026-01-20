#!/bin/bash
set -e pipefail
export DEBIAN_FRONTEND=noninteractive
exec > >(tee -a /var/log/user-data.log | logger -t user-data) 2>&1

sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    python3-pip \
    python3.12-venv

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -

sudo apt-get install -y nodejs

sudo npm install -g pm2

echo node --version
echo npm --version
echo python3-pip ---version

## Install Docker
sudo apt-get install -y docker.io

## Add Jenkins to the system
## Java
sudo apt-get install -y fontconfig openjdk-21-jre

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins

## Add current user to docker
sudo usermod -aG docker $USER
sudo usermod -aG docker jenkins

newgrp docker

echo "Execution Successful"