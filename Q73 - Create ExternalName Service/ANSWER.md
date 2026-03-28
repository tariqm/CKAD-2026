# Answer 73 – Create ExternalName Service

## Step-by-step Solution

### Step 1: Create the ExternalName service

```bash
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Service
metadata:
  name: external-db
  namespace: q73
spec:
  type: ExternalName
  externalName: db.example.com
EOF
```

## Verify

```bash
# Check service exists and has correct type
kubectl get svc external-db -n q73

# Verify the external name
kubectl get svc external-db -n q73 -o jsonpath='{.spec.externalName}'

# Test DNS resolution from a pod
kubectl run dns-test --rm -it --restart=Never --image=busybox:latest -n q73 -- nslookup external-db.q73.svc.cluster.local
```
