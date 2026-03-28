# Answer 63 – Create NetworkPolicy Default Deny All

## Steps

### 1. Create the default deny all ingress NetworkPolicy

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all-ingress
  namespace: q63
spec:
  podSelector: {}
  policyTypes:
  - Ingress
EOF
```

The key points:
- `podSelector: {}` selects all pods in the namespace.
- `policyTypes: [Ingress]` with no `ingress` rules means all ingress is denied.

## Verify

```bash
# Check the NetworkPolicy
kubectl get networkpolicy deny-all-ingress -n q63

# Describe it
kubectl describe networkpolicy deny-all-ingress -n q63
```
