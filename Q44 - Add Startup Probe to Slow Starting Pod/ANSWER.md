# Answer 44 – Add Startup Probe to Slow Starting Pod

## Steps

### Step 1: Create the Pod with startup probe

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: slow-start-pod
  namespace: q44
spec:
  containers:
  - name: nginx
    image: nginx:latest
    ports:
    - containerPort: 80
    startupProbe:
      httpGet:
        path: /healthz
        port: 80
      failureThreshold: 30
      periodSeconds: 10
EOF
```

## Verify

```bash
kubectl get pod slow-start-pod -n q44
kubectl describe pod slow-start-pod -n q44 | grep -A 5 "Startup"
```

Expected: pod exists with startup probe configured, failureThreshold 30, periodSeconds 10. The startup probe gives the application up to 300 seconds (30 x 10) to start.
