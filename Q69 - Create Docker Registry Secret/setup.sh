#!/bin/bash
set -euo pipefail
echo "=== Q69 Setup: Create Docker Registry Secret ==="

kubectl create namespace q69 --dry-run=client -o yaml | kubectl apply -f -

echo "✅ Q69 setup complete."
