#!/bin/bash
set -euo pipefail

kubectl create namespace q28 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: crashing-pod
  namespace: q28
spec:
  restartPolicy: Always
  containers:
  - name: app
    image: busybox:latest
    command: ["sh", "-c", "echo starting app; cat /config/missing-file.conf; exit 1"]
EOF

echo "Setup complete for Q28."
