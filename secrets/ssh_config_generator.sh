#!/usr/bin/env bash
# Author : Harry
# blog  : harry-thedevopsguy.blogspot.com

# Run
# ./ssh_config_generator.sh 'bastion_public ip' 

echo "################################## Generating SSH CONFIG"
export PROJECT_ROOT="$(git rev-parse --show-toplevel)"
export BASTION_PUBLIC_IP="${1}"
envsubst < ${PROJECT_ROOT}/secrets/ssh_config.tmpl > ${PROJECT_ROOT}/secrets/ssh_config
