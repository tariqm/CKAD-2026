#!/bin/bash
set -euo pipefail

kubectl create namespace q68 --dry-run=client -o yaml | kubectl apply -f -

echo "Q68 setup complete."
