# Answer 24 – Create Pod with Command and Args Override

## Steps

### 1. Create the Pod with custom command and args

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: custom-cmd-pod
  namespace: q24
spec:
  containers:
  - name: busybox
    image: busybox:latest
    command: ["sh", "-c"]
    args: ["echo Hello CKAD && sleep 3600"]
EOF
```

## Verify

```bash
# Check pod status
kubectl get pod custom-cmd-pod -n q24

# Check logs to see "Hello CKAD"
kubectl logs custom-cmd-pod -n q24

# Verify command
kubectl get pod custom-cmd-pod -n q24 -o jsonpath='{.spec.containers[0].command}'
```
