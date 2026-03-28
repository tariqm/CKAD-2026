# Answer 31 – Create Deployment from Scratch with Port

## Steps

### 1. Create the Deployment

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-frontend
  namespace: q31
spec:
  replicas: 4
  selector:
    matchLabels:
      app: web-frontend
  template:
    metadata:
      labels:
        app: web-frontend
        tier: frontend
    spec:
      containers:
      - name: httpd
        image: httpd:latest
        ports:
        - containerPort: 80
EOF
```

Alternatively, using `kubectl create`:

```bash
kubectl create deployment web-frontend -n q31 --image=httpd:latest --replicas=4 --port=80 --dry-run=client -o yaml | \
  kubectl label --local -f - tier=frontend -o yaml --dry-run=client | \
  kubectl apply -f -
```

## Verify

```bash
# Check deployment
kubectl get deployment web-frontend -n q31

# Check replicas and image
kubectl describe deployment web-frontend -n q31

# Check labels on pods
kubectl get pods -n q31 --show-labels
```
