#!/bin/bash
set -euo pipefail

kubectl create namespace q50 --dry-run=client -o yaml | kubectl apply -f -

echo "Setup complete. Namespace q50 created."
