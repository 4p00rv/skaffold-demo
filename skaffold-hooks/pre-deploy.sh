#! /bin/bash

set -e

if [ ! -f "$HOME/.kube/config" ]; then
  echo "No Kubeconfig found at $HOME/.kube/config"
  exit 1
fi

