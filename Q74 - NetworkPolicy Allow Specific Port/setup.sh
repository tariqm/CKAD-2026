#!/bin/bash
set -euo pipefail
echo "=== Q74 Setup: NetworkPolicy Allow Specific Port ==="

kubectl create namespace q74 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deploy
  namespace: q74
spec:
  replicas: 1
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

echo "✅ Q74 setup complete."
