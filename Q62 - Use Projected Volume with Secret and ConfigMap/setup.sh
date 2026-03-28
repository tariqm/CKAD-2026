#!/bin/bash
set -euo pipefail
echo "=== Q62 Setup: Use Projected Volume with Secret and ConfigMap ==="

kubectl create namespace q62 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
  namespace: q62
type: Opaque
stringData:
  db-password: "s3cretP@ss"
EOF

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: q62
data:
  app.properties: |
    environment=production
    log_level=info
EOF

echo "✅ Q62 setup complete."
