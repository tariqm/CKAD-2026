#!/bin/bash
set -euo pipefail
echo "=== Q4 Setup: Fix Broken Pod with Correct ServiceAccount ==="

kubectl create namespace q04 --dry-run=client -o yaml | kubectl apply -f -

kubectl create sa monitor-sa -n q04 --dry-run=client -o yaml | kubectl apply -f -
kubectl create sa wrong-sa -n q04 --dry-run=client -o yaml | kubectl apply -f -
kubectl create sa admin-sa -n q04 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: metrics-reader
  namespace: q04
rules:
  - apiGroups: [""]
    resources: ["pods", "pods/log"]
    verbs: ["get", "list", "watch"]
  - apiGroups: ["metrics.k8s.io"]
    resources: ["pods"]
    verbs: ["get", "list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: full-access
  namespace: q04
rules:
  - apiGroups: ["*"]
    resources: ["*"]
    verbs: ["*"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: view-only
  namespace: q04
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["get"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: monitor-binding
  namespace: q04
subjects:
  - kind: ServiceAccount
    name: monitor-sa
    namespace: q04
roleRef:
  kind: Role
  name: metrics-reader
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: admin-binding
  namespace: q04
subjects:
  - kind: ServiceAccount
    name: admin-sa
    namespace: q04
roleRef:
  kind: Role
  name: full-access
  apiGroup: rbac.authorization.k8s.io
EOF

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: metrics-pod
  namespace: q04
spec:
  serviceAccountName: wrong-sa
  containers:
    - name: metrics
      image: curlimages/curl:latest
      command:
        - sh
        - -c
        - |
          while true; do
            echo "Attempting to read metrics..."
            RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" \
              -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
              --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
              "https://kubernetes.default.svc/api/v1/namespaces/q04/pods" 2>&1)
            if [ "$RESPONSE" != "200" ]; then
              echo "ERROR: Authorization failed - cannot list pods with current ServiceAccount"
            else
              echo "Successfully retrieved metrics"
            fi
            sleep 10
          done
EOF

kubectl wait --for=condition=Ready pod/metrics-pod -n q04 --timeout=60s 2>/dev/null || true
echo "✅ Q4 setup complete."
