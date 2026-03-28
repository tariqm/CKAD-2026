#!/bin/bash
set -euo pipefail

kubectl create namespace q40 --dry-run=client -o yaml | kubectl apply -f -

cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: restart-app
  namespace: q40
spec:
  replicas: 3
  selector:
    matchLabels:
      app: restart-app
  template:
    metadata:
      labels:
        app: restart-app
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
EOF

kubectl rollout status deployment/restart-app -n q40 --timeout=60s

echo "Setup complete for Q44"
