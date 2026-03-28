#!/bin/bash
set -euo pipefail
echo "=== Q13 Setup: Create NodePort Service ==="

kubectl create namespace q13 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-server
  namespace: q13
spec:
  replicas: 2
  selector:
    matchLabels:
      app: api
  template:
    metadata:
      labels:
        app: api
    spec:
      containers:
        - name: api
          image: nginx:latest
          ports:
            - containerPort: 9090
EOF

kubectl rollout status deploy/api-server -n q13 --timeout=120s
echo "✅ Q13 setup complete. Deployment api-server with label app=api, port 9090."
