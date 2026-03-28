# Answer 20 – Create Pod with EmptyDir Shared Volume

## Steps

### 1. Create the Pod with shared emptyDir volume

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: shared-vol-pod
  namespace: q20
spec:
  containers:
  - name: writer
    image: busybox:latest
    command: ["sh", "-c", "while true; do date >> /data/output.txt; sleep 5; done"]
    volumeMounts:
    - name: shared-data
      mountPath: /data
  - name: reader
    image: busybox:latest
    command: ["sh", "-c", "tail -f /data/output.txt"]
    volumeMounts:
    - name: shared-data
      mountPath: /data
  volumes:
  - name: shared-data
    emptyDir: {}
EOF
```

## Verify

```bash
# Check pod status
kubectl get pod shared-vol-pod -n q20

# Check that the writer is writing data
kubectl exec shared-vol-pod -n q20 -c reader -- cat /data/output.txt

# Check reader logs (should show dates)
kubectl logs shared-vol-pod -n q20 -c reader
```
