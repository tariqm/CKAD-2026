# Answer 12 – Fix Service Selector

## Step 1 – Check current state

```bash
kubectl get pods -n q12 --show-labels
kubectl get svc web-svc -n q12 -o yaml
kubectl get endpoints web-svc -n q12   # Should be empty
```

## Step 2 – Update Service selector

```bash
kubectl edit svc web-svc -n q12
```

Change `app: wrongapp` to `app: webapp`:

```yaml
spec:
  selector:
    app: webapp
```

## Step 3 – Verify endpoints

```bash
kubectl get endpoints web-svc -n q12
# Should now show IPs of web-app pods
```
