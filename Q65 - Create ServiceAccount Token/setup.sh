#!/bin/bash
set -euo pipefail
echo "=== Q65 Setup: Create ServiceAccount Token ==="

kubectl create namespace q65 --dry-run=client -o yaml | kubectl apply -f -

echo "✅ Q65 setup complete."
