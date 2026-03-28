#!/bin/bash
set -euo pipefail

kubectl create namespace q18 --dry-run=client -o yaml | kubectl apply -f -

cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: mydb
  namespace: q18
spec:
  type: ClusterIP
  ports:
  - port: 3306
    targetPort: 3306
EOF

echo "Setup complete for Q18."
