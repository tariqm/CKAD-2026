#!/bin/bash
set -euo pipefail
echo "=== Q10 Setup: Add Readiness Probe to Deployment ==="

kubectl create namespace q10 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-deploy
  namespace: q10
spec:
  replicas: 2
  selector:
    matchLabels:
      app: api-deploy
  template:
    metadata:
      labels:
        app: api-deploy
    spec:
      containers:
        - name: api
          image: nginx:latest
          ports:
            - containerPort: 8080
EOF

kubectl rollout status deploy/api-deploy -n q10 --timeout=120s
echo "✅ Q10 setup complete. Deployment api-deploy running, no readiness probe."
