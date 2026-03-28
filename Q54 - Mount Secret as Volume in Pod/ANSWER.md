# Answer 54 – Mount Secret as Volume in Pod

## Steps

1. Create the Pod manifest with the Secret volume mount:

```bash
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: secure-pod
  namespace: q54
spec:
  containers:
  - name: nginx
    image: nginx:latest
    volumeMounts:
    - name: tls-volume
      mountPath: /etc/tls
      readOnly: true
  volumes:
  - name: tls-volume
    secret:
      secretName: tls-certs
EOF
```

## Verify

```bash
# Check the pod is created
kubectl get pod secure-pod -n q54

# Verify the volume mount
kubectl describe pod secure-pod -n q54 | grep -A5 "Mounts"

# Check the secret files are available
kubectl exec secure-pod -n q54 -- ls /etc/tls
```
