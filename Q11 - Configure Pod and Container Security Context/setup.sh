#!/bin/bash
set -euo pipefail
echo "=== Q11 Setup: Configure Pod and Container Security Context ==="
kubectl create namespace q11 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: secure-app
  namespace: q11
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
        - name: app
          image: nginx:latest
          ports:
            - containerPort: 80
EOF

kubectl rollout status deploy/secure-app -n q11 --timeout=120s
echo "✅ Q11 setup complete. Deployment secure-app running, no security context."
