#! /bin/bash

######Install Calico Networking Plugin######

sudo kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.2/manifests/tigera-operator.yaml
sudo kubectl apply -f /root/kubernetes-binary-install-1/manifests/calico/resources.yaml

