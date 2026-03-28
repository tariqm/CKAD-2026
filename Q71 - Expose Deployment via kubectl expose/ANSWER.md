# Answer 71 – Expose Deployment via kubectl expose

## Step-by-step Solution

### Step 1: Expose the deployment using kubectl expose

```bash
kubectl expose deployment api-deploy \
  --name=api-svc \
  --namespace=q71 \
  --port=8080 \
  --target-port=80 \
  --type=ClusterIP
```

## Verify

```bash
# Check service exists
kubectl get svc api-svc -n q71

# Check endpoints are populated
kubectl get endpoints api-svc -n q71

# Test connectivity
kubectl run curl-test --rm -it --restart=Never --image=curlimages/curl -n q71 -- curl -s http://api-svc:8080
```
