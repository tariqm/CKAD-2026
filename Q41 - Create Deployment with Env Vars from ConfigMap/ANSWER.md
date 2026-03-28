# Answer 41 – Create Deployment with Env Vars from ConfigMap

## Steps

### Step 1: Create the Deployment with envFrom

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: env-app
  namespace: q41
spec:
  replicas: 2
  selector:
    matchLabels:
      app: env-app
  template:
    metadata:
      labels:
        app: env-app
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        envFrom:
        - configMapRef:
            name: app-config
EOF
```

## Verify

```bash
kubectl get deployment env-app -n q41
kubectl get deployment env-app -n q41 -o jsonpath='{.spec.template.spec.containers[0].envFrom}'

# Verify env vars are set in a running pod
POD=$(kubectl get pods -n q41 -l app=env-app -o jsonpath='{.items[0].metadata.name}')
kubectl exec "$POD" -n q41 -- env | grep -E "APP_ENV|APP_DEBUG"
```

Expected: `APP_ENV=production` and `APP_DEBUG=false` in the pod environment.
