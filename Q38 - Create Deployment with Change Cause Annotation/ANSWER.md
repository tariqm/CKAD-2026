# Answer 38 – Create Deployment with Change Cause Annotation

## Steps

### Step 1: Create the Deployment

```bash
kubectl create deployment tracked-app --image=nginx:1.20 --replicas=3 -n q38
```

### Step 2: Annotate with initial change cause

```bash
kubectl annotate deployment tracked-app -n q38 kubernetes.io/change-cause="Initial deployment with nginx:1.20"
```

### Step 3: Update image to nginx:1.25

```bash
kubectl set image deployment/tracked-app nginx=nginx:1.25 -n q38
```

### Step 4: Annotate with updated change cause

```bash
kubectl annotate deployment tracked-app -n q38 kubernetes.io/change-cause="Updated to nginx:1.25" --overwrite
```

### Step 5: Wait for rollout

```bash
kubectl rollout status deployment/tracked-app -n q38
```

## Verify

```bash
kubectl rollout history deployment/tracked-app -n q38
```

Expected output should show at least 2 revisions with their change-cause annotations.
