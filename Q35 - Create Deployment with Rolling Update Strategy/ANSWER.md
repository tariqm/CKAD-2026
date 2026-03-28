# Answer 35 – Create Deployment with Rolling Update Strategy

## Steps

### 1. Create the Deployment with rolling update strategy

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: rolling-app
  namespace: q35
spec:
  replicas: 5
  selector:
    matchLabels:
      app: rolling-app
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 2
      maxUnavailable: 1
  template:
    metadata:
      labels:
        app: rolling-app
    spec:
      containers:
      - name: nginx
        image: nginx:1.20
        ports:
        - containerPort: 80
EOF
```

## Verify

```bash
# Check deployment
kubectl get deployment rolling-app -n q35

# Check strategy details
kubectl get deployment rolling-app -n q35 -o jsonpath='{.spec.strategy}'

# Describe for full details
kubectl describe deployment rolling-app -n q35 | grep -A3 "RollingUpdateStrategy"
```
