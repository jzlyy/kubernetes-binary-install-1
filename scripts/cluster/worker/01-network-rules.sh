#! /bin/bash

######Network Configuration Rules######

#Load the br_netfilter Kernel Module
sudo cp /root/kubernetes-binary-install-1/configs/modules-load.conf /etc/modules-load.d/k8s.conf
sudo systemctl restart systemd-modules-load.service

#Modify Linux Kernel Parameters (enable bridge traffic forwarding)
sudo cp /root/kubernetes-binary-install-1/configs/network.conf /etc/sysctl.d/k8s.conf
sudo sysctl -p /etc/sysctl.d/k8s.conf

#Define IPVS Prerequisites (for kube-proxy initialization)
#Download IPVS packages
sudo dnf -y install ipvsadm
sudo mkdir -p /etc/sysconfig/modules
sudo cp /root/kubernetes-binary-install-1/configs/ipvs.conf /etc/sysconfig/modules/ipvs.modules

#Apply/Source the Script File
sudo chmod 755 /etc/sysconfig/modules/ipvs.modules
sudo /bin/bash /etc/sysconfig/modules/ipvs.modules
sudo lsmod | grep -e ip_vs -e nf_conntrack

