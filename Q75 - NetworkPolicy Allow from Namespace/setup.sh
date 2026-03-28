#!/bin/bash
set -euo pipefail
echo "=== Q75 Setup: NetworkPolicy Allow from Namespace ==="

kubectl create namespace q75 --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace q75-frontend --dry-run=client -o yaml | kubectl apply -f -
kubectl label namespace q75-frontend purpose=frontend --overwrite

kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend-deploy
  namespace: q75
spec:
  replicas: 1
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
EOF

echo "✅ Q75 setup complete."
