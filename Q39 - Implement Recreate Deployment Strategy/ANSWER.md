# Answer 39 – Implement Recreate Deployment Strategy

## Steps

### Step 1: Create the Deployment with Recreate strategy

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: recreate-app
  namespace: q39
spec:
  replicas: 3
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app: recreate-app
  template:
    metadata:
      labels:
        app: recreate-app
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
EOF
```

## Verify

```bash
kubectl get deployment recreate-app -n q39
kubectl get deployment recreate-app -n q39 -o jsonpath='{.spec.strategy.type}'
```

Expected: strategy type is `Recreate`, 3 replicas.
