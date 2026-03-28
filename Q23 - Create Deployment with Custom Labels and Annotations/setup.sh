#!/bin/bash
set -euo pipefail

kubectl create namespace q23 --dry-run=client -o yaml | kubectl apply -f -

echo "Setup complete for Q23."
