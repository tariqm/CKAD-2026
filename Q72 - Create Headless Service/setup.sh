#!/bin/bash
set -euo pipefail
echo "=== Q72 Setup: Create Headless Service ==="

kubectl create namespace q72 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: db-sts
  namespace: q72
spec:
  serviceName: db-headless
  replicas: 2
  selector:
    matchLabels:
      app: db
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
      - name: busybox
        image: busybox:latest
        command: ["sh", "-c", "sleep 3600"]
        ports:
        - containerPort: 5432
EOF

echo "✅ Q72 setup complete."
