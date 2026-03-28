# Answer 32 – Create Temporary Debug Pod

## Steps

### 1. Create the debug Pod

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: debug-pod
  namespace: q32
spec:
  restartPolicy: Never
  containers:
  - name: debug
    image: busybox:latest
    command: ["wget", "-qO-", "http://backend-svc.q32.svc.cluster.local"]
EOF
```

Alternatively, using `kubectl run`:

```bash
kubectl run debug-pod -n q32 --image=busybox:latest --restart=Never -- wget -qO- http://backend-svc.q32.svc.cluster.local
```

## Verify

```bash
# Check pod status (should complete or show logs)
kubectl get pod debug-pod -n q32

# Check pod logs to see the wget output
kubectl logs debug-pod -n q32

# Verify restartPolicy
kubectl get pod debug-pod -n q32 -o jsonpath='{.spec.restartPolicy}'
```
