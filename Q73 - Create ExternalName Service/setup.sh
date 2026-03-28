#!/bin/bash
set -euo pipefail
echo "=== Q73 Setup: Create ExternalName Service ==="

kubectl create namespace q73 --dry-run=client -o yaml | kubectl apply -f -

echo "✅ Q73 setup complete."
