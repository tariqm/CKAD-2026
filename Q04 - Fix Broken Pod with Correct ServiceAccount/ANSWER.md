# Answer 4 – Fix Broken Pod with Correct ServiceAccount

## Step 1 – Investigate existing RBAC resources

```bash
kubectl get rolebindings -n q04 -o yaml
kubectl get roles -n q04 -o yaml
kubectl describe rolebinding monitor-binding -n q04
kubectl describe role metrics-reader -n q04
```

`monitor-binding` binds `monitor-sa` to `metrics-reader`, which has the needed permissions. Use `monitor-sa`.

## Step 2 – Update Pod

```bash
kubectl get pod metrics-pod -n q04 -o yaml > /tmp/metrics-pod.yaml
# Edit to change serviceAccountName to monitor-sa
kubectl delete pod metrics-pod -n q04
kubectl apply -f /tmp/metrics-pod.yaml
```

## Step 3 – Verify

```bash
kubectl logs metrics-pod -n q04
# Should no longer show authorization errors
```
