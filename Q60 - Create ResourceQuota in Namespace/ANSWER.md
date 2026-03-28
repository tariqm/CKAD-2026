# Answer 60 – Create ResourceQuota in Namespace

## Steps

### 1. Create the ResourceQuota

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-quota
  namespace: q60
spec:
  hard:
    requests.cpu: "1"
    limits.cpu: "2"
    requests.memory: 1Gi
    limits.memory: 2Gi
EOF
```

## Verify

```bash
# Check the ResourceQuota
kubectl get resourcequota compute-quota -n q60

# See detailed usage
kubectl describe resourcequota compute-quota -n q60
```
