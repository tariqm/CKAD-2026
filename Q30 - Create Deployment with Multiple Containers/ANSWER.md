# Answer 30 – Create Deployment with Multiple Containers

## Steps

### 1. Create the Deployment with two containers

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: multi-deploy
  namespace: q30
spec:
  replicas: 2
  selector:
    matchLabels:
      app: multi-deploy
  template:
    metadata:
      labels:
        app: multi-deploy
    spec:
      containers:
      - name: web
        image: nginx:latest
        ports:
        - containerPort: 80
      - name: metrics
        image: busybox:latest
        command: ["/bin/sh", "-c", "while true; do echo metrics; sleep 10; done"]
EOF
```

## Verify

```bash
# Check deployment status
kubectl get deployment multi-deploy -n q30

# Check containers in the pods
kubectl get pods -n q30 -l app=multi-deploy -o jsonpath='{.items[0].spec.containers[*].name}'

# Check logs from metrics container
kubectl logs -n q30 -l app=multi-deploy -c metrics --tail=5
```
