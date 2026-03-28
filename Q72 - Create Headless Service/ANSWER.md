# Answer 72 – Create Headless Service

## Step-by-step Solution

### Step 1: Create the headless service

```bash
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Service
metadata:
  name: db-headless
  namespace: q72
spec:
  clusterIP: None
  selector:
    app: db
  ports:
  - port: 5432
    targetPort: 5432
EOF
```

## Verify

```bash
# Check service exists and has no cluster IP
kubectl get svc db-headless -n q72

# Check that DNS returns individual pod IPs
kubectl run dns-test --rm -it --restart=Never --image=busybox:latest -n q72 -- nslookup db-headless.q72.svc.cluster.local

# Access individual pods via DNS
# db-sts-0.db-headless.q72.svc.cluster.local
# db-sts-1.db-headless.q72.svc.cluster.local
```
