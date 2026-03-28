# Answer 9 – Perform Rolling Update and Rollback

## Step 1 – Update the image

```bash
kubectl set image deploy/app-v1 web=nginx:1.25 -n default
```

## Step 2 – Monitor the rollout

```bash
kubectl rollout status deploy app-v1 -n default
```

## Step 3 – View rollout history

```bash
kubectl rollout history deploy app-v1 -n default
```

## Step 4 – Rollback to previous revision

```bash
kubectl rollout undo deploy app-v1 -n default
```

Or to a specific revision:

```bash
kubectl rollout undo deploy app-v1 --to-revision=1 -n default
```

## Step 5 – Verify rollback

```bash
kubectl rollout status deploy app-v1 -n default
kubectl get deploy app-v1 -o jsonpath='{.spec.template.spec.containers[0].image}'
# Should show nginx:1.20
```
