# Answer 7 – Fix NetworkPolicy by Updating Pod Labels

## Step 1 – View existing NetworkPolicies

```bash
kubectl get networkpolicies -n q07 -o yaml
```

Identify the label selectors: `role=frontend`, `role=backend`, `role=db`.

## Step 2 – Update Pod labels

```bash
kubectl label pod frontend -n q07 role=frontend --overwrite
kubectl label pod backend -n q07 role=backend --overwrite
kubectl label pod database -n q07 role=db --overwrite
```

## Step 3 – Verify

```bash
kubectl get pods -n q07 --show-labels
kubectl describe networkpolicy allow-frontend-to-backend -n q07
kubectl describe networkpolicy allow-backend-to-db -n q07
```
