# Answer 64 – Drop All Capabilities and Add Specific Ones

## Steps

### 1. Create the Pod with capabilities configuration

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: secure-pod
  namespace: q64
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    securityContext:
      capabilities:
        drop:
        - ALL
        add:
        - NET_BIND_SERVICE
EOF
```

## Verify

```bash
# Check the pod
kubectl get pod secure-pod -n q64

# Verify the security context
kubectl get pod secure-pod -n q64 -o jsonpath='{.spec.containers[0].securityContext.capabilities}'

# Describe for full details
kubectl describe pod secure-pod -n q64 | grep -A5 "Capabilities"
```
