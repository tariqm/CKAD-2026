#!/bin/bash
set -euo pipefail

kubectl create namespace q33 --dry-run=client -o yaml | kubectl apply -f -

echo "Setup complete for Q33 - Create Pod with Resource Requests Only"
