# Answer 29 – Create Pod with HostPath Volume

## Steps

### 1. Create the Pod with a hostPath volume

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: hostpath-pod
  namespace: q29
spec:
  containers:
  - name: nginx
    image: nginx:latest
    volumeMounts:
    - name: web-volume
      mountPath: /usr/share/nginx/html
  volumes:
  - name: web-volume
    hostPath:
      path: /data/web
      type: DirectoryOrCreate
EOF
```

## Verify

```bash
# Check pod is running
kubectl get pod hostpath-pod -n q29

# Check volume details
kubectl describe pod hostpath-pod -n q29 | grep -A5 "Volumes"

# Check mount path
kubectl get pod hostpath-pod -n q29 -o jsonpath='{.spec.containers[0].volumeMounts[0].mountPath}'
```
