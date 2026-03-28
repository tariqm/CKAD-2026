# Answer 23 – Create Deployment with Custom Labels and Annotations

## Steps

### 1. Create the Deployment with labels and annotations

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: labeled-app
  namespace: q23
spec:
  replicas: 3
  selector:
    matchLabels:
      app: labeled-app
  template:
    metadata:
      labels:
        app: labeled-app
        tier: frontend
        env: staging
      annotations:
        description: "Frontend staging deployment"
    spec:
      containers:
      - name: nginx
        image: nginx:latest
EOF
```

## Verify

```bash
# Check deployment
kubectl get deployment labeled-app -n q23

# Check labels on pods
kubectl get pods -n q23 --show-labels

# Check annotations
kubectl get pods -n q23 -o jsonpath='{.items[0].metadata.annotations.description}'
```
