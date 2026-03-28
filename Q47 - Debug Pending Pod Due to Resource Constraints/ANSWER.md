# Answer 47 – Debug Pending Pod Due to Resource Constraints

## Step 1: Check the ResourceQuota

```bash
kubectl describe resourcequota compute-quota -n q47
```

This shows the quota limits and current usage. You will see that `existing-pod` is using 400m CPU request and 200Mi memory request.

## Step 2: Calculate remaining quota

- Remaining CPU requests: 500m - 400m = 100m
- Remaining memory requests: 256Mi - 200Mi = 56Mi
- Remaining CPU limits: 1 - 800m = 200m
- Remaining memory limits: 512Mi - 400Mi = 112Mi

## Step 3: Create fixed-pod with adjusted resources

```bash
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: fixed-pod
  namespace: q47
spec:
  containers:
  - name: app
    image: nginx:latest
    resources:
      requests:
        cpu: "100m"
        memory: "50Mi"
      limits:
        cpu: "200m"
        memory: "100Mi"
EOF
```

## Verify

```bash
kubectl get pods -n q47
kubectl describe resourcequota compute-quota -n q47
kubectl get pod fixed-pod -n q47 -o wide
```
