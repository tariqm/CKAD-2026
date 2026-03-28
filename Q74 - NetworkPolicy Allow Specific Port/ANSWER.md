# Answer 74 – NetworkPolicy Allow Specific Port

## Step-by-step Solution

### Step 1: Create the NetworkPolicy

```bash
kubectl apply -f - <<'EOF'
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-port-80
  namespace: q74
spec:
  podSelector:
    matchLabels:
      app: web
  policyTypes:
  - Ingress
  ingress:
  - ports:
    - protocol: TCP
      port: 80
EOF
```

## Verify

```bash
# Check NetworkPolicy exists
kubectl get networkpolicy allow-port-80 -n q74

# Describe to see full details
kubectl describe networkpolicy allow-port-80 -n q74
```
