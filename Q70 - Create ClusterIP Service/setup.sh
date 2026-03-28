#!/bin/bash
set -euo pipefail
echo "=== Q70 Setup: Create ClusterIP Service ==="

kubectl create namespace q70 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deploy
  namespace: q70
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
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
EOF

echo "✅ Q70 setup complete."
