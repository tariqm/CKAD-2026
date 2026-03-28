#!/bin/bash
set -euo pipefail

kubectl create namespace q47 --dry-run=client -o yaml | kubectl apply -f -

# Create ResourceQuota
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-quota
  namespace: q47
spec:
  hard:
    requests.cpu: "500m"
    requests.memory: "256Mi"
    limits.cpu: "1"
    limits.memory: "512Mi"
EOF

# Create existing pod that uses most of the quota
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: existing-pod
  namespace: q47
spec:
  containers:
  - name: app
    image: nginx:latest
    resources:
      requests:
        cpu: "400m"
        memory: "200Mi"
      limits:
        cpu: "800m"
        memory: "400Mi"
EOF

# Create a broken pod spec that exceeds remaining quota
cat > /root/pending-pod.yaml <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: greedy-pod
  namespace: q47
spec:
  containers:
  - name: app
    image: nginx:latest
    resources:
      requests:
        cpu: "500m"
        memory: "200Mi"
      limits:
        cpu: "800m"
        memory: "400Mi"
EOF

echo "Setup complete. Check /root/pending-pod.yaml"
