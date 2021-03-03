#!/bin/bash

CYAN='\033[1;36m'
GREEN='\033[0;32m'
LBLUE='\033[1;34m'
NC='\033[0m'

# Access ArgoCD UI
echo -e "${CYAN} > > >  Access ArgoCD UI:${NC}${GREEN} localhost:8088${NC}\n"
kubectl port-forward svc/argocd-server -n argocd 8088:443 >/dev/null 2>&1 &

# Access Online Boutique
echo -e "${CYAN} > > >  Access Online Boutique:${NC}${GREEN} localhost:8000${NC}\n"
kubectl port-forward svc/frontend -n default 8000:80 >/dev/null 2>&1 &
