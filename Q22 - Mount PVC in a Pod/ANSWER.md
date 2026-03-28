# Answer 22 – Mount PVC in a Pod

## Steps

### 1. Create the Pod with the PVC mounted

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: pvc-pod
  namespace: q22
spec:
  containers:
  - name: nginx
    image: nginx:latest
    volumeMounts:
    - name: data-volume
      mountPath: /usr/share/nginx/html
  volumes:
  - name: data-volume
    persistentVolumeClaim:
      claimName: data-pvc
EOF
```

## Verify

```bash
# Check pod status
kubectl get pod pvc-pod -n q22

# Verify the volume mount
kubectl describe pod pvc-pod -n q22 | grep -A 5 "Mounts:"

# Verify the volume references the PVC
kubectl get pod pvc-pod -n q22 -o jsonpath='{.spec.volumes[*].persistentVolumeClaim.claimName}'
```
