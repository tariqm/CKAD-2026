# Answer 8 – Fix Broken Deployment YAML

## Step 1 – View the broken file

```bash
cat /root/broken-deploy.yaml
```

## Step 2 – Fix the file

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: broken-app
  namespace: default
spec:
  replicas: 2
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
        - name: web
          image: nginx
```

## Step 3 – Apply and verify

```bash
kubectl apply -f /root/broken-deploy.yaml
kubectl get deploy broken-app
kubectl rollout status deploy broken-app
kubectl get pods -l app=myapp
```
