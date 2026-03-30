# Answer 16 – Add Resource Requests and Limits to Pod

## Step 1 – Check the ResourceQuota

```bash
kubectl get quota -n q16
kubectl describe quota compute-quota -n q16
```

Shows: `limits.cpu: "2"`, `limits.memory: "4Gi"` → half = `cpu: "1"`, `memory: "2Gi"`

## Step 2 – Create the Pod

```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: resource-pod
  namespace: q16
spec:
  containers:
    - name: web
      image: nginx:latest
      resources:
        requests:
          cpu: "100m"
          memory: "128Mi"
        limits:
          cpu: "1"
          memory: "2Gi"
EOF
```

**Note:** Adjust limit values based on what the ResourceQuota actually shows. If quota shows `limits.cpu: "4"`, use `cpu: "2"`.
