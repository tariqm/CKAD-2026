#!/bin/bash
set -euo pipefail

kubectl create namespace q52 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: troubleshoot-app
  namespace: q52
spec:
  replicas: 3
  selector:
    matchLabels:
      app: troubleshoot-app
  template:
    metadata:
      labels:
        app: troubleshoot-app
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
EOF

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Service
metadata:
  name: troubleshoot-svc
  namespace: q52
spec:
  selector:
    app: wrong-app
  ports:
  - port: 80
    targetPort: 80
EOF

echo "Setup complete. Deployment and Service created (Service has wrong selector)."
