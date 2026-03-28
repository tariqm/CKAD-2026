# Answer 34 – Scale Deployment

## Steps

### 1. Scale the Deployment to 6 replicas

```bash
kubectl scale deployment scale-app -n q34 --replicas=6
```

## Verify

```bash
# Check deployment replicas
kubectl get deployment scale-app -n q34

# Watch pods scale up
kubectl get pods -n q34 -l app=scale-app
```
