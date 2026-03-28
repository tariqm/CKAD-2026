#!/bin/bash
set -euo pipefail

kubectl create namespace q46 --dry-run=client -o yaml | kubectl apply -f -

cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: log-app
  namespace: q46
spec:
  replicas: 3
  selector:
    matchLabels:
      app: log-app
  template:
    metadata:
      labels:
        app: log-app
    spec:
      containers:
      - name: busybox
        image: busybox:latest
        command: ["sh", "-c", "while true; do echo \"$(date) INFO: healthy\"; sleep 5; done"]
EOF

cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: error-pod
  namespace: q46
spec:
  containers:
  - name: busybox
    image: busybox:latest
    command: ["sh", "-c", "while true; do echo 'ERROR: something failed'; sleep 5; done"]
EOF

echo "Setup complete for Q50"
