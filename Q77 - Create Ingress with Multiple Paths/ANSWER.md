# Answer 77 – Create Ingress with Multiple Paths

## Step-by-step Solution

### Step 1: Create the Ingress with multiple paths

```bash
kubectl apply -f - <<'EOF'
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: multi-path-ingress
  namespace: q77
spec:
  rules:
  - host: app.example.com
    http:
      paths:
      - path: /frontend
        pathType: Prefix
        backend:
          service:
            name: frontend-svc
            port:
              number: 80
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: api-svc
            port:
              number: 80
EOF
```

## Verify

```bash
# Check Ingress exists
kubectl get ingress multi-path-ingress -n q77

# Describe to see routing rules
kubectl describe ingress multi-path-ingress -n q77
```
