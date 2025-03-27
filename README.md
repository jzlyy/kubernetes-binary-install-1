# kubernetes-binary-install-1
[![GitHub License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen)](CONTRIBUTING.md)

High Availability (HA) Cluster using kubeadm and keepalived (Docker container runtime)

>This project provides a one-click script for rapidly deploying a highly available Kubernetes cluster (supports versions 1.24+) in production environments, utilizing Docker as the runtime and Calico as the CNI.

## Table of Contents
- [Features](#Features)
- [Environment](#Environment)
- [Start](#Start)
- [Detailed](#Detailed)
- [Architecture](#Architecture)
- [Case](#Case)
---
## Features
**Core Features**
- One-click deployment of a highly available Kubernetes control plane with multi-Master node load balancing.
- Automated TLS certificate issuance for components (etcd, apiserver, kubelet).
- Optimized configuration for the Containerd runtime.
- Integration of CNI plugins (Calico/Flannel, etc.) with NetworkPolicy support.

**Extended Capabilities**
- Optional deployment of Ingress Controller (Nginx).
- Support for offline environment deployment with a shell-based installation script.
- Built-in Prometheus + Grafana monitoring suite for real-time cluster metrics collection.
---

## Environment
### **Hardware Configuration**
| Role       | CPU     | Memory | Disk  |
|------------|---------|--------|-------|
| Master     | 4cores  | 6GB    | 60GB  | 
| Worker     | 4cores  | 8GB    | 100GB |

### **Version Compatibility**
| Kubernetes Versions |         Tested CNI Versions          |  Docker Versions |
|---------------------|--------------------------------------|------------------|
| 1.32.3              | Calico 3.29.2  Flannel 0.26.5        | 1.7+             |
| 1.31.6              | Calico 3.29.1  Flannel 0.26.1        | 1.6+             |

### **Software Dependencies**
- OS: CentOS 7.9+ / Rocky Linux 8.6+ 
- Container Runtime: Docker 3.27+
- Kernel: ≥ 5.4（recommended with `overlay2` and `ipvs` modules enabled).

### **Network Requirements**
- Control plane nodes must open ports: `6443` (apiserver), `2379-2380` (etcd).
- Time synchronization between nodes with skew < 1ms (NTP service required).
---
## Start
### Download the Installation Package
    wget https://github.com/jzlyy/kubernetes-binary-install-2/archive/refs/tags/v1.32.3.tar.gz

### Extract the Package and Enter the Directory
    tar -xf v1.32.3.tar.gz
    mv kubernetes-binary-install-2-1.32.3 kubernetes-binary-install-2
#### Master
    cd kubernetes-binary-install-2/scripts
    sh execute_host-master.sh 
    sh execute_cluster-master.sh
### Master-backup
    cd kubernetes-binary-install-2/scripts
    sh execute_host-master-backup.sh
    sh execute_cluster-master-backup.sh
#### Worker
    cd kubernetes-binary-install-2/scripts
    sh execute_host-worker.sh
    sh execute_cluster-worker.sh
---
## Detailed
### Customize kubeadm Templates
    Modify the core parameters in configs/kubeadm-config.yaml：
    apiVersion: kubeadm.k8s.io/v1beta3
    kind: ClusterConfiguration
    kubernetesVersion: v1.32.3
    controlPlaneEndpoint: "172.168.20.110:16443"  # High Availability VIP Address
    networking:
      podSubnet: "192.168.0.0/16"         # Must be compatible with the CNI plugin
    apiServer:
      certSANs:                           # Certificate SAN Extension (Subject Alternative Name)
        - "172.168.20.90"
        - "127.0.0.1"
        - "kubernetes.default.svc"
---
## Architecture
### High Availability Control Plane Architecture
    sequenceDiagram
    participant Client
    participant VIP
    participant Master1
    participant Master2
    participant etcd

    Client->>VIP: kubectl API Server Port (6443)
    VIP-->>Master1: Load Balancer
    Master1->>etcd: Data Read/Write (Port 2379)
    Master1-->>Client: Response
    Master2->>etcd: Data Synchronization
---
## Case

The Cloud Computing Laboratory of Neijiang Vocational and Technical College implemented this solution to deploy a highly available Kubernetes cluster, enabling API Service to handle requests with high concurrency, high throughput, and low latency.

---
## Contribution Guidelines

Welcome to contribute code! Please follow these steps:
1. Fork this repository and create a branch.
2. Run ./test_cluster-master to ensure all tests pass before submitting code.
3. Submit a Pull Request with a description of your changes.

For detailed workflows, refer to [CONTRIBUTING.md](CONTRIBUTING.md)。

## Maintainers
- [jzlyy](https://github.com/jzlyy)

## Security Policy
To report security vulnerabilities, please see [SECURITY.md](SECURITY.md)。
