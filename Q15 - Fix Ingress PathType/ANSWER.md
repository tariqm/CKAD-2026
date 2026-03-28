# Answer 15 – Fix Ingress PathType

## Step 1 – Try to apply (will fail)

```bash
kubectl apply -f /root/fix-ingress.yaml
# Error: pathType: Unsupported value: "InvalidType"
```

## Step 2 – Fix the file

Change `pathType: InvalidType` to `pathType: Prefix`:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: api-ingress
  namespace: default
spec:
  rules:
    - http:
        paths:
          - path: /api
            pathType: Prefix
            backend:
              service:
                name: api-svc
                port:
                  number: 8080
```

## Step 3 – Apply

```bash
kubectl apply -f /root/fix-ingress.yaml
kubectl get ingress api-ingress -n default
```
