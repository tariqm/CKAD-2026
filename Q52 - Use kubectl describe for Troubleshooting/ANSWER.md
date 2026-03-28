# Answer 52 – Use kubectl describe for Troubleshooting

## Step 1: Diagnose the issue

```bash
kubectl describe service troubleshoot-svc -n q52
kubectl get endpoints troubleshoot-svc -n q52
kubectl describe deployment troubleshoot-app -n q52
kubectl get pods -n q52 --show-labels
```

The Service selector is `app=wrong-app` but the pods have label `app=troubleshoot-app`.

## Step 2: Fix the Service selector

```bash
kubectl patch service troubleshoot-svc -n q52 --type='json' \
  -p='[{"op": "replace", "path": "/spec/selector/app", "value": "troubleshoot-app"}]'
```

Or delete and recreate:

```bash
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Service
metadata:
  name: troubleshoot-svc
  namespace: q52
spec:
  selector:
    app: troubleshoot-app
  ports:
  - port: 80
    targetPort: 80
EOF
```

## Verify

```bash
kubectl get endpoints troubleshoot-svc -n q52
kubectl describe service troubleshoot-svc -n q52
```

The Endpoints field should now show the pod IPs.
