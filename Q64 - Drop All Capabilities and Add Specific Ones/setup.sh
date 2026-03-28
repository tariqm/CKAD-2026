#!/bin/bash
set -euo pipefail
echo "=== Q64 Setup: Drop All Capabilities and Add Specific Ones ==="

kubectl create namespace q64 --dry-run=client -o yaml | kubectl apply -f -

echo "✅ Q64 setup complete."
