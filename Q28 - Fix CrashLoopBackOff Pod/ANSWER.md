# Answer 28 – Fix CrashLoopBackOff Pod

## Steps

### Step 1: Diagnose the issue

```bash
kubectl get pod crashing-pod -n q28
kubectl describe pod crashing-pod -n q28
kubectl logs crashing-pod -n q28
```

The logs show "starting app" followed by an error because `/config/missing-file.conf` does not exist, and the command exits with code 1.

### Step 2: Delete the existing pod

```bash
kubectl delete pod crashing-pod -n q28
```

### Step 3: Recreate with fixed command

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: crashing-pod
  namespace: q28
spec:
  restartPolicy: Always
  containers:
  - name: app
    image: busybox:latest
    command: ["sh", "-c", "echo starting app; sleep 3600"]
EOF
```

## Verify

```bash
kubectl get pod crashing-pod -n q28
```

Expected: Pod is in `Running` state.
