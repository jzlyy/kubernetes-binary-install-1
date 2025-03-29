#! /bin/bash

######Install Docker environment######

#Enable Docker CE YUM repository
cd /etc/yum.repos.d || exit 1
sudo wget https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
sudo dnf makecache

#Download Docker CE packages
sudo dnf -y install docker-ce

#Configure Docker image accelerator
sudo mkdir -p /etc/docker
sudo cp /root/kubernetes-binary-install-1/configs/daemon.json /etc/docker/daemon.json

#Start Docker service
sudo systemctl daemon-reload
sudo systemctl enable docker
sudo systemctl start docker

#Download cri-dockerd interaction tool
sudo wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.16/cri-dockerd-0.3.16.amd64.tgz
sudo tar -xf cri-dockerd-0.3.16.amd64.tgz
sudo mv cri-dockerd/cri-dockerd /usr/local/bin/

#Configure the cri-dockerd service file
sudo cp /root/kubernetes-binary-install-1/configs/cri-dockerd.service /usr/lib/systemd/system 

#Start cri-dockerd service
sudo systemctl daemon-reload
sudo systemctl enable cri-dockerd.service
sudo systemctl start cri-dockerd.service

#Restart Docker service
sudo systemctl restart docker




