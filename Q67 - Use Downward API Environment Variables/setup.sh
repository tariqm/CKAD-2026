#!/bin/bash
set -euo pipefail

kubectl create namespace q67 --dry-run=client -o yaml | kubectl apply -f -

echo "Q67 setup complete."
