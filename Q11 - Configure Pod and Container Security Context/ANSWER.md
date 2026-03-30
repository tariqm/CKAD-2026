# Answer 11 – Configure Pod and Container Security Context

## Step 1 – Edit the Deployment

```bash
kubectl edit deploy secure-app -n q11
```

Add security context at both levels:

```yaml
spec:
  template:
    spec:
      securityContext:        # Pod-level
        runAsUser: 1000
      containers:
        - name: app
          image: nginx
          securityContext:    # Container-level
            capabilities:
              add:
                - NET_ADMIN
```

## Step 2 – Verify

```bash
kubectl rollout status deploy secure-app -n q11
kubectl get pod -n q11 -l app=secure-app -o yaml | grep -A 10 securityContext
```
