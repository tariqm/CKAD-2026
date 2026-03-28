#!/bin/bash
set -euo pipefail

kubectl create namespace q49 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: monitored-app
  namespace: q49
spec:
  replicas: 3
  selector:
    matchLabels:
      app: monitored-app
  template:
    metadata:
      labels:
        app: monitored-app
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        resources:
          requests:
            cpu: "50m"
            memory: "64Mi"
        ports:
        - containerPort: 80
EOF

echo "Setup complete. Deployment 'monitored-app' with 3 replicas created."
