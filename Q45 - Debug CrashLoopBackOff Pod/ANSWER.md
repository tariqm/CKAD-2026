# Answer 45 – Debug CrashLoopBackOff Pod

## Steps

### Step 1: Diagnose the issue

```bash
kubectl get pod crashing-pod -n q45
kubectl describe pod crashing-pod -n q45
kubectl logs crashing-pod -n q45
```

The logs show "starting" and the pod exits with code 1 due to `exit 1` in the command.

### Step 2: Delete the existing pod

```bash
kubectl delete pod crashing-pod -n q45
```

### Step 3: Recreate with fixed command

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: crashing-pod
  namespace: q45
spec:
  restartPolicy: Always
  containers:
  - name: busybox
    image: busybox:latest
    command: ["sh", "-c", "echo starting; sleep 3600"]
EOF
```

## Verify

```bash
kubectl get pod crashing-pod -n q45
```

Expected: pod is in `Running` state.
