# Answer 36 – Blue-Green Deployment Switch

## Steps

### 1. Verify current Service selector

```bash
kubectl get svc app-svc -n q36 -o jsonpath='{.spec.selector}'
```

You should see `{"app":"myapp","version":"blue"}`.

### 2. Switch the Service selector from blue to green

```bash
kubectl patch svc app-svc -n q36 -p '{"spec":{"selector":{"version":"green"}}}'
```

Alternatively, you can edit the Service directly:

```bash
kubectl edit svc app-svc -n q36
# Change selector version from "blue" to "green"
```

## Verify

```bash
# Confirm the selector now points to green
kubectl get svc app-svc -n q36 -o jsonpath='{.spec.selector}'

# Check that endpoints now resolve to the green pods
kubectl get endpoints app-svc -n q36
```
