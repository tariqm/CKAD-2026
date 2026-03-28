# Answer 42 – Fix Failed Deployment Rollout

## Steps

### Step 1: Diagnose the issue

```bash
kubectl get deployment broken-deploy -n q42
kubectl get pods -n q42
kubectl describe deployment broken-deploy -n q42
```

You will see pods in `ImagePullBackOff` due to the invalid image `nginx:invalid-tag-9999`.

### Step 2: Fix the image

```bash
kubectl set image deployment/broken-deploy nginx=nginx:latest -n q42
```

### Step 3: Wait for rollout to complete

```bash
kubectl rollout status deployment/broken-deploy -n q42
```

## Verify

```bash
kubectl get deployment broken-deploy -n q42
kubectl get pods -n q42
kubectl get deployment broken-deploy -n q42 -o jsonpath='{.spec.template.spec.containers[0].image}'
```

Expected: image is `nginx:latest`, all pods running.
