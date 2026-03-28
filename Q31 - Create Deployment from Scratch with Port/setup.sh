#!/bin/bash
set -euo pipefail

kubectl create namespace q31 --dry-run=client -o yaml | kubectl apply -f -

echo "Setup complete for Q31 - Create Deployment from Scratch with Port"
