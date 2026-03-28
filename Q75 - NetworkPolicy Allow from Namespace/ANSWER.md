# Answer 75 – NetworkPolicy Allow from Namespace

## Step-by-step Solution

### Step 1: Create the NetworkPolicy

```bash
kubectl apply -f - <<'EOF'
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-from-frontend
  namespace: q75
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
  - Ingress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          purpose: frontend
EOF
```

## Verify

```bash
# Check NetworkPolicy exists
kubectl get networkpolicy allow-from-frontend -n q75

# Describe to see full details
kubectl describe networkpolicy allow-from-frontend -n q75

# Verify the frontend namespace has the correct label
kubectl get namespace q75-frontend --show-labels
```
