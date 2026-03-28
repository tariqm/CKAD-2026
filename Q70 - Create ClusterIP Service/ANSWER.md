# Answer 70 – Create ClusterIP Service

## Step-by-step Solution

### Step 1: Create the ClusterIP service

```bash
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Service
metadata:
  name: web-svc
  namespace: q70
spec:
  type: ClusterIP
  selector:
    app: web
  ports:
  - port: 80
    targetPort: 80
EOF
```

## Verify

```bash
# Check service exists and has correct type
kubectl get svc web-svc -n q70

# Check endpoints are populated
kubectl get endpoints web-svc -n q70

# Test connectivity from a temporary pod
kubectl run curl-test --rm -it --restart=Never --image=curlimages/curl -n q70 -- curl -s http://web-svc
```
