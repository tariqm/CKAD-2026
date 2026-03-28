# Answer 40 – Rolling Restart Deployment

## Steps

### Step 1: Perform a rolling restart

```bash
kubectl rollout restart deployment/restart-app -n q40
```

### Step 2: Wait for rollout to complete

```bash
kubectl rollout status deployment/restart-app -n q40
```

## Verify

```bash
kubectl rollout history deployment/restart-app -n q40
```

Expected: at least 2 revisions in the rollout history, confirming the restart created a new revision.
