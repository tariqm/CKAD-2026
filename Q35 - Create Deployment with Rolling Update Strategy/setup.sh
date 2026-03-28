#!/bin/bash
set -euo pipefail

kubectl create namespace q35 --dry-run=client -o yaml | kubectl apply -f -

echo "Setup complete for Q35 - Create Deployment with Rolling Update Strategy"
