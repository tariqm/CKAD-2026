# Answer 76 – NetworkPolicy Egress Rules

## Step-by-step Solution

### Step 1: Create the NetworkPolicy with egress rules

```bash
kubectl apply -f - <<'EOF'
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: restrict-egress
  namespace: q76
spec:
  podSelector:
    matchLabels:
      app: secure-app
  policyTypes:
  - Egress
  egress:
  - ports:
    - protocol: TCP
      port: 53
    - protocol: UDP
      port: 53
  - ports:
    - protocol: TCP
      port: 443
EOF
```

## Verify

```bash
# Check NetworkPolicy exists
kubectl get networkpolicy restrict-egress -n q76

# Describe to see full details
kubectl describe networkpolicy restrict-egress -n q76
```
