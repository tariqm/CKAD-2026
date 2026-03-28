#!/bin/bash
set -euo pipefail

kubectl create namespace q60 --dry-run=client -o yaml | kubectl apply -f -

echo "Setup complete for Q71"
