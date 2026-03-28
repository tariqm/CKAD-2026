#!/bin/bash
set -euo pipefail
echo "=== Q61 Setup: Create LimitRange in Namespace ==="

kubectl create namespace q61 --dry-run=client -o yaml | kubectl apply -f -

echo "✅ Q61 setup complete."
