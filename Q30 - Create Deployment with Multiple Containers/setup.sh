#!/bin/bash
set -euo pipefail

kubectl create namespace q30 --dry-run=client -o yaml | kubectl apply -f -

echo "Setup complete for Q30 - Create Deployment with Multiple Containers"
