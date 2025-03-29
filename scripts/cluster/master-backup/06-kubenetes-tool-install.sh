#! /bin/bash

######Install kubeadm, kubelet, and kubectl######

sudo dnf -y install kubelet  kubeadm  kubectl

#Start the kubelet Service
sudo systemctl daemon-reload
sudo systemctl enable kubelet
sudo systemctl start kubelet
