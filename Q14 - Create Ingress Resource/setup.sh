#!/bin/bash
set -euo pipefail
echo "=== Q14 Setup: Create Ingress Resource ==="

kubectl create namespace q14 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deploy
  namespace: q14
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
        - name: web
          image: nginx:latest
          ports:
            - containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: web-svc
  namespace: q14
spec:
  selector:
    app: web
  ports:
    - port: 8080
      targetPort: 8080
      protocol: TCP
EOF

kubectl rollout status deploy/web-deploy -n q14 --timeout=120s
echo "✅ Q14 setup complete. Deployment web-deploy and Service web-svc on port 8080."
