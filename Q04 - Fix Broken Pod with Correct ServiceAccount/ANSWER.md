# Answer 4 – Fix Broken Pod with Correct ServiceAccount

## Step 1 – Investigate existing RBAC resources

```bash
kubectl get rolebindings -n monitoring -o yaml
kubectl get roles -n monitoring -o yaml
kubectl describe rolebinding monitor-binding -n monitoring
kubectl describe role metrics-reader -n monitoring
```

`monitor-binding` binds `monitor-sa` to `metrics-reader`, which has the needed permissions. Use `monitor-sa`.

## Step 2 – Update Pod

```bash
kubectl get pod metrics-pod -n monitoring -o yaml > /tmp/metrics-pod.yaml
# Edit to change serviceAccountName to monitor-sa
kubectl delete pod metrics-pod -n monitoring
kubectl apply -f /tmp/metrics-pod.yaml
```

## Step 3 – Verify

```bash
kubectl logs metrics-pod -n monitoring
# Should no longer show authorization errors
```
