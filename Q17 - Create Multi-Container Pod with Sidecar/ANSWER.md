# Answer 17 – Create Multi-Container Pod with Sidecar

## Steps

### 1. Create the multi-container Pod

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: web-with-sidecar
  namespace: q17
spec:
  containers:
  - name: nginx
    image: nginx:latest
    ports:
    - containerPort: 80
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log/nginx
  - name: sidecar
    image: busybox:latest
    command: ["sh", "-c", "while true; do wget -q -O - http://localhost:80 >> /var/log/nginx/access.log; sleep 5; done"]
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log/nginx
  volumes:
  - name: shared-logs
    emptyDir: {}
EOF
```

## Verify

```bash
# Check pod status
kubectl get pod web-with-sidecar -n q17

# Verify both containers are running
kubectl describe pod web-with-sidecar -n q17 | grep -A 3 "Containers:"

# Check logs from sidecar
kubectl logs web-with-sidecar -n q17 -c sidecar
```
