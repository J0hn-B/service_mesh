#!/usr/bin/env bash

# Parameters
CLUSTER=$(k3d cluster list multiserver)

# Check if K3d exists
if [ $(command -v k3d) ]; then
    echo "--> k3d exists, skip install"
else
    echo "> > > k3d does not exist, installing now"
    wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
fi

# Prepare the k3d cluster
if [ "$CLUSTER" ]; then
    echo "Cluster exists"
else
    echo "--> multiserver cluster does not exist, creating now"
    k3d cluster create multiserver --servers 1 --agents 2
fi

# Install ArgoCD
echo
source ./argocd_install.sh

# Deploy cluster bootstrap
cd .. && kubectl apply -f k8s/argo_config/

#  Deploy app
kubectl apply -f app/argo_config/
