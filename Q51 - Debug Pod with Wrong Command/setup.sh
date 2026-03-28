#!/bin/bash
set -euo pipefail

kubectl create namespace q51 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: wrong-cmd-pod
  namespace: q51
spec:
  containers:
  - name: nginx
    image: nginx:latest
    command: ["nginx-wrong", "-g", "daemon off;"]
EOF

echo "Setup complete. Pod 'wrong-cmd-pod' created with wrong command."
