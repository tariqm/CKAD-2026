# Answer 14 – Create Ingress Resource

```bash
cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web-ingress
  namespace: default
spec:
  rules:
    - host: web.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: web-svc
                port:
                  number: 8080
EOF
```

## Verify

```bash
kubectl get ingress web-ingress -n default
kubectl describe ingress web-ingress -n default
```
