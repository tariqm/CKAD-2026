#!/bin/bash
set -euo pipefail
echo "=== Q6 Setup: Canary Deployment with Manual Traffic Split ==="

kubectl create namespace q06 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  namespace: q06
spec:
  replicas: 5
  selector:
    matchLabels:
      app: webapp
      version: v1
  template:
    metadata:
      labels:
        app: webapp
        version: v1
    spec:
      containers:
        - name: web
          image: nginx:latest
          ports:
            - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: web-service
  namespace: q06
spec:
  selector:
    app: webapp
  ports:
    - port: 80
      targetPort: 80
      protocol: TCP
EOF

kubectl rollout status deploy/web-app -n q06 --timeout=120s
echo "✅ Q6 setup complete."
