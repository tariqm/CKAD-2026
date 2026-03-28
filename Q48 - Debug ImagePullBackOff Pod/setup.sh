#!/bin/bash
set -euo pipefail

kubectl create namespace q48 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: bad-image-pod
  namespace: q48
spec:
  containers:
  - name: app
    image: nginx:nonexistent-tag-12345
    ports:
    - containerPort: 80
EOF

echo "Setup complete. Pod 'bad-image-pod' created with bad image tag."
