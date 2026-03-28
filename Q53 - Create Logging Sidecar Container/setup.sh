#!/bin/bash
set -euo pipefail

kubectl create namespace q53 --dry-run=client -o yaml | kubectl apply -f -

echo "Setup complete. Namespace q53 created."
