# Answer 48 – Debug ImagePullBackOff Pod

## Step 1: Diagnose the issue

```bash
kubectl get pods -n q48
kubectl describe pod bad-image-pod -n q48
```

The Events section will show `Failed to pull image "nginx:nonexistent-tag-12345"`.

## Step 2: Delete the broken pod

```bash
kubectl delete pod bad-image-pod -n q48
```

## Step 3: Recreate with correct image

```bash
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: bad-image-pod
  namespace: q48
spec:
  containers:
  - name: app
    image: nginx:latest
    ports:
    - containerPort: 80
EOF
```

## Verify

```bash
kubectl get pods -n q48
kubectl describe pod bad-image-pod -n q48 | grep Image
```
