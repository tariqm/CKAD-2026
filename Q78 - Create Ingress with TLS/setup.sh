#!/bin/bash
set -euo pipefail

kubectl create namespace q78 --dry-run=client -o yaml | kubectl apply -f -

cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: secure-web
  namespace: q78
spec:
  replicas: 2
  selector:
    matchLabels:
      app: secure-web
  template:
    metadata:
      labels:
        app: secure-web
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
EOF

cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: secure-web-svc
  namespace: q78
spec:
  selector:
    app: secure-web
  ports:
  - port: 443
    targetPort: 80
EOF

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /tmp/q78-tls.key -out /tmp/q78-tls.crt \
  -subj "/CN=secure.example.com" 2>/dev/null

kubectl create secret tls tls-secret \
  --cert=/tmp/q78-tls.crt \
  --key=/tmp/q78-tls.key \
  -n q78

rm -f /tmp/q78-tls.key /tmp/q78-tls.crt

echo "Setup complete for Q89."
