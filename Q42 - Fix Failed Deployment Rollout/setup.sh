#!/bin/bash
set -euo pipefail

kubectl create namespace q42 --dry-run=client -o yaml | kubectl apply -f -

cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: broken-deploy
  namespace: q42
spec:
  replicas: 3
  selector:
    matchLabels:
      app: broken-deploy
  template:
    metadata:
      labels:
        app: broken-deploy
    spec:
      containers:
      - name: nginx
        image: nginx:invalid-tag-9999
        ports:
        - containerPort: 80
EOF

echo "Setup complete for Q46"
