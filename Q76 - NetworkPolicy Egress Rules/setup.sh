#!/bin/bash
set -euo pipefail
echo "=== Q76 Setup: NetworkPolicy Egress Rules ==="

kubectl create namespace q76 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-deploy
  namespace: q76
spec:
  replicas: 1
  selector:
    matchLabels:
      app: secure-app
  template:
    metadata:
      labels:
        app: secure-app
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: api-svc
  namespace: q76
spec:
  selector:
    app: secure-app
  ports:
  - port: 443
    targetPort: 80
EOF

echo "✅ Q76 setup complete."
