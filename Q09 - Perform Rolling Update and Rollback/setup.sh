#!/bin/bash
set -euo pipefail
echo "=== Q9 Setup: Perform Rolling Update and Rollback ==="

kubectl create namespace q09 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-v1
  namespace: q09
spec:
  replicas: 3
  selector:
    matchLabels:
      app: app-v1
  template:
    metadata:
      labels:
        app: app-v1
    spec:
      containers:
        - name: web
          image: nginx:1.20
          ports:
            - containerPort: 80
EOF

kubectl rollout status deploy/app-v1 -n q09 --timeout=120s
echo "✅ Q9 setup complete. Deployment app-v1 running with nginx:1.20."
