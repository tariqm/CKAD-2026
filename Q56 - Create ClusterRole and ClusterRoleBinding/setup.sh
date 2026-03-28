#!/bin/bash
set -euo pipefail

kubectl create namespace q56 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: ServiceAccount
metadata:
  name: cluster-viewer
  namespace: q56
EOF

echo "Setup complete for Q67"
