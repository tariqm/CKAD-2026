#!/bin/bash
set -euo pipefail

kubectl create namespace q66 --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: ServiceAccount
metadata:
  name: deploy-sa
  namespace: q66
EOF

kubectl apply -f - <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: deploy-role
  namespace: q66
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list"]
EOF

kubectl apply -f - <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: deploy-binding
  namespace: q66
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: deploy-role
subjects:
- kind: ServiceAccount
  name: deploy-sa
  namespace: q66
EOF

kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: deploy-tool
  namespace: q66
spec:
  serviceAccountName: deploy-sa
  containers:
  - name: deploy-tool
    image: busybox:latest
    command: ["sleep", "3600"]
EOF

echo "Q66 setup complete."
