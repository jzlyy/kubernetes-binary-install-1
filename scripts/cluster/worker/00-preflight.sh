#! /bin/bash

######Pre-configure######

#Modify the hostname
sudo hostnamectl set-hostname worker-node1

#Configure DNS resolution for the host
sudo cat /root/kubernetes-binary-install-1/configs/hosts | sudo tee -a /etc/hosts >/dev/null

#Disable SELinux (not recommended in production environments)
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

#Disable firewall
sudo systemctl stop firewalld
sudo systemctl disable firewalld

#Disable swap
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

#Reboot the system
bash
