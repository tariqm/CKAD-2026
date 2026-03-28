#!/bin/bash
set -euo pipefail
echo "=== Q3 Setup: ServiceAccount, Role, and RoleBinding from Logs Error ==="

kubectl create namespace q03 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: log-collector
  namespace: q03
spec:
  serviceAccountName: default
  containers:
    - name: log-collector
      image: curlimages/curl:latest
      command:
        - sh
        - -c
        - |
          while true; do
            echo "Attempting to list pods..."
            RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" \
              -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
              --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
              "https://kubernetes.default.svc/api/v1/namespaces/q03/pods" 2>&1)
            if [ "$RESPONSE" != "200" ]; then
              echo "ERROR: User \"system:serviceaccount:q03:default\" cannot list pods in the namespace \"q03\""
            else
              echo "Successfully listed pods"
            fi
            sleep 10
          done
EOF

kubectl wait --for=condition=Ready pod/log-collector -n q03 --timeout=60s 2>/dev/null || true
echo "✅ Q3 setup complete."
