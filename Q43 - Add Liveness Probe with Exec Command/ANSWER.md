# Answer 43 – Add Liveness Probe with Exec Command

## Steps

### Step 1: Create the Pod with exec liveness probe

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: liveness-exec-pod
  namespace: q43
spec:
  containers:
  - name: busybox
    image: busybox:latest
    command: ["sh", "-c", "touch /tmp/healthy; sleep 3600"]
    livenessProbe:
      exec:
        command:
        - cat
        - /tmp/healthy
      initialDelaySeconds: 5
      periodSeconds: 10
EOF
```

## Verify

```bash
kubectl get pod liveness-exec-pod -n q43
kubectl describe pod liveness-exec-pod -n q43 | grep -A 5 "Liveness"
```

Expected: pod is Running, liveness probe is exec-based with `cat /tmp/healthy`, initialDelaySeconds 5, periodSeconds 10.
