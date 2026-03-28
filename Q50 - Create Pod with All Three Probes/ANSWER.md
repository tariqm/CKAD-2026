# Answer 50 – Create Pod with All Three Probes

## Step 1: Create pod with all three probes

```bash
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: triple-probe-pod
  namespace: q50
spec:
  containers:
  - name: nginx
    image: nginx:latest
    ports:
    - containerPort: 80
    startupProbe:
      httpGet:
        path: /
        port: 80
      failureThreshold: 30
      periodSeconds: 10
    livenessProbe:
      httpGet:
        path: /
        port: 80
      periodSeconds: 15
    readinessProbe:
      httpGet:
        path: /
        port: 80
      periodSeconds: 5
EOF
```

## Verify

```bash
kubectl get pod triple-probe-pod -n q50
kubectl describe pod triple-probe-pod -n q50 | grep -A 5 -E "(Liveness|Readiness|Startup)"
```
