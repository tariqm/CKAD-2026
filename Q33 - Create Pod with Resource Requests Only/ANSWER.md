# Answer 33 – Create Pod with Resource Requests Only

## Steps

### 1. Create the Pod with resource requests

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: request-pod
  namespace: q33
spec:
  containers:
  - name: nginx
    image: nginx:latest
    resources:
      requests:
        cpu: "250m"
        memory: "128Mi"
EOF
```

## Verify

```bash
# Check pod is running
kubectl get pod request-pod -n q33

# Check resource requests
kubectl get pod request-pod -n q33 -o jsonpath='{.spec.containers[0].resources}'

# Confirm no limits are set
kubectl get pod request-pod -n q33 -o jsonpath='{.spec.containers[0].resources.limits}'
```
