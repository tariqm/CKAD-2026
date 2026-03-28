#!/bin/bash
set -euo pipefail

kubectl create namespace q41 --dry-run=client -o yaml | kubectl apply -f -

cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: q41
data:
  APP_ENV: "production"
  APP_DEBUG: "false"
EOF

echo "Setup complete for Q45"
