# Answer 21 – Create PersistentVolume and PersistentVolumeClaim

## Steps

### 1. Create the PersistentVolume (cluster-scoped, no namespace)

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: task-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
  - ReadWriteOnce
  hostPath:
    path: /mnt/data
  storageClassName: manual
EOF
```

### 2. Create the PersistentVolumeClaim in namespace q21

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: task-pvc
  namespace: q21
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi
  storageClassName: manual
EOF
```

## Verify

```bash
# Check PV status
kubectl get pv task-pv

# Check PVC status (should be Bound)
kubectl get pvc task-pvc -n q21

# Verify binding
kubectl describe pvc task-pvc -n q21 | grep "Volume:"
```
