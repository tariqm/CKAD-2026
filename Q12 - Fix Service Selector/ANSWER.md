# Answer 12 – Fix Service Selector

## Step 1 – Check current state

```bash
kubectl get pods -n default --show-labels
kubectl get svc web-svc -n default -o yaml
kubectl get endpoints web-svc -n default   # Should be empty
```

## Step 2 – Update Service selector

```bash
kubectl edit svc web-svc -n default
```

Change `app: wrongapp` to `app: webapp`:

```yaml
spec:
  selector:
    app: webapp
```

## Step 3 – Verify endpoints

```bash
kubectl get endpoints web-svc -n default
# Should now show IPs of web-app pods
```
