#!/bin/bash
set -euo pipefail

kubectl create namespace q34 --dry-run=client -o yaml | kubectl apply -f -

cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: scale-app
  namespace: q34
spec:
  replicas: 2
  selector:
    matchLabels:
      app: scale-app
  template:
    metadata:
      labels:
        app: scale-app
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
EOF

echo "Setup complete for Q34 - Scale Deployment"
