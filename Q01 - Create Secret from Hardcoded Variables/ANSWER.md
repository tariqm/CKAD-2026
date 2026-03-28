# Answer 1 – Create Secret from Hardcoded Variables

## Step 1 – Create the Secret

```bash
kubectl create secret generic db-credentials \
  --from-literal=DB_USER=admin \
  --from-literal=DB_PASS=Secret123! \
  -n default
```

## Step 2 – Update Deployment to use Secret

```bash
kubectl edit deploy api-server -n default
```

Replace the hardcoded environment variables:

```yaml
env:
  - name: DB_USER
    valueFrom:
      secretKeyRef:
        name: db-credentials
        key: DB_USER
  - name: DB_PASS
    valueFrom:
      secretKeyRef:
        name: db-credentials
        key: DB_PASS
```

Save and exit. Verify:

```bash
kubectl rollout status deploy api-server -n default
```
