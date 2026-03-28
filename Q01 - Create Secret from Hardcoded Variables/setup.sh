#!/bin/bash
set -euo pipefail
echo "=== Q1 Setup: Create Secret from Hardcoded Variables ==="

kubectl create namespace q01 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-server
  namespace: q01
spec:
  replicas: 1
  selector:
    matchLabels:
      app: api-server
  template:
    metadata:
      labels:
        app: api-server
    spec:
      containers:
        - name: api
          image: busybox:latest
          command: ["sh", "-c", "while true; do echo \"DB_USER=$DB_USER DB_PASS=$DB_PASS\"; sleep 60; done"]
          env:
            - name: DB_USER
              value: "admin"
            - name: DB_PASS
              value: "Secret123!"
EOF

kubectl rollout status deploy/api-server -n q01 --timeout=60s
echo "✅ Q1 setup complete."
