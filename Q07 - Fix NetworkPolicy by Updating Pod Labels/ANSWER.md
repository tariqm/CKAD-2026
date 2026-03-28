# Answer 7 – Fix NetworkPolicy by Updating Pod Labels

## Step 1 – View existing NetworkPolicies

```bash
kubectl get networkpolicies -n network-demo -o yaml
```

Identify the label selectors: `role=frontend`, `role=backend`, `role=db`.

## Step 2 – Update Pod labels

```bash
kubectl label pod frontend -n network-demo role=frontend --overwrite
kubectl label pod backend -n network-demo role=backend --overwrite
kubectl label pod database -n network-demo role=db --overwrite
```

## Step 3 – Verify

```bash
kubectl get pods -n network-demo --show-labels
kubectl describe networkpolicy allow-frontend-to-backend -n network-demo
kubectl describe networkpolicy allow-backend-to-db -n network-demo
```
