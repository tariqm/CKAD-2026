#!/bin/bash
set -euo pipefail

kubectl create namespace q54 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Secret
metadata:
  name: tls-certs
  namespace: q54
type: Opaque
stringData:
  tls.crt: "CERT-DATA-PLACEHOLDER"
  tls.key: "KEY-DATA-PLACEHOLDER"
EOF

echo "Setup complete for Q65"
