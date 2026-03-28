#!/bin/bash
set -euo pipefail
echo "=== Q8 Setup: Fix Broken Deployment YAML ==="
kubectl create namespace q08 --dry-run=client -o yaml | kubectl apply -f -

cat >./broken-deploy.yaml <<'YAMLEOF'
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: broken-app
  namespace: q08
spec:
  replicas: 2
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
        - name: web
          image: nginx
YAMLEOF

echo "✅ Q8 setup complete. /root/broken-deploy.yaml created with intentional errors."
