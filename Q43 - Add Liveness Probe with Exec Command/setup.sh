#!/bin/bash
set -euo pipefail

kubectl create namespace q43 --dry-run=client -o yaml | kubectl apply -f -

echo "Setup complete for Q47"
