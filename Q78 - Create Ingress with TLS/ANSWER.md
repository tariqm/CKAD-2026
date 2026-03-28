# Answer 78 – Create Ingress with TLS

## Steps

### 1. Create the Ingress with TLS

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: secure-ingress
  namespace: q78
spec:
  tls:
  - hosts:
    - secure.example.com
    secretName: tls-secret
  rules:
  - host: secure.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: secure-web-svc
            port:
              number: 443
EOF
```

## Verify

```bash
# Check the Ingress was created
kubectl get ingress secure-ingress -n q78

# Verify TLS configuration
kubectl describe ingress secure-ingress -n q78

# Confirm TLS secret and host
kubectl get ingress secure-ingress -n q78 -o jsonpath='{.spec.tls}' | jq .
```
