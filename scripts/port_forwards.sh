#!/bin/bash

CYAN='\033[1;36m'
GREEN='\033[0;32m'
LBLUE='\033[1;34m'
NC='\033[0m'

# Access Online Boutique
echo -e "${CYAN} > > >  Access Online Boutique:${NC}${GREEN} kubectl port-forward svc/frontend -n default 8000:80${NC}\n"

# Access Consul
echo -e "${CYAN} > > >  Access Consul:${NC}${GREEN} kubectl port-forward svc/consul-consul-ui -n consul 8500:80${NC}\n"
