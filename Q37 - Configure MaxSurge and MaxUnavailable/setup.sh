#!/bin/bash
set -euo pipefail

kubectl create namespace q37 --dry-run=client -o yaml | kubectl apply -f -

cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: strategy-app
  namespace: q37
spec:
  replicas: 4
  selector:
    matchLabels:
      app: strategy-app
  template:
    metadata:
      labels:
        app: strategy-app
    spec:
      containers:
      - name: nginx
        image: nginx:1.20
        ports:
        - containerPort: 80
EOF

echo "Setup complete for Q41"
