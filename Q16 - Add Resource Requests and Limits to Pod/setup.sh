#!/bin/bash
set -euo pipefail
echo "=== Q16 Setup: Add Resource Requests and Limits to Pod ==="

kubectl create namespace q16 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-quota
  namespace: q16
spec:
  hard:
    limits.cpu: "2"
    limits.memory: "4Gi"
    requests.cpu: "1"
    requests.memory: "2Gi"
    pods: "5"
EOF

echo "✅ Q16 setup complete. Namespace q16 with ResourceQuota (limits.cpu: 2, limits.memory: 4Gi)."
