# Answer 6 – Create Canary Deployment with Manual Traffic Split

## Step 1 – Scale existing Deployment

```bash
kubectl scale deploy web-app --replicas=8 -n default
```

## Step 2 – Create canary Deployment

```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app-canary
  namespace: default
spec:
  replicas: 2
  selector:
    matchLabels:
      app: webapp
      version: v2
  template:
    metadata:
      labels:
        app: webapp
        version: v2
    spec:
      containers:
        - name: web
          image: nginx:latest
EOF
```

## Step 3 – Verify

```bash
kubectl get endpoints web-service -n default
kubectl get pods -n default -l app=webapp --show-labels
```

Both `version=v1` and `version=v2` pods should appear in endpoints.
