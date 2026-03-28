#!/bin/bash
set -euo pipefail

kubectl create namespace q45 --dry-run=client -o yaml | kubectl apply -f -

cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: crashing-pod
  namespace: q45
spec:
  restartPolicy: Always
  containers:
  - name: busybox
    image: busybox:latest
    command: ["sh", "-c", "echo starting; exit 1"]
EOF

echo "Setup complete for Q49"
