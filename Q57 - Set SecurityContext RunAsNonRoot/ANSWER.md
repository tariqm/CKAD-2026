# Answer 57 – Set SecurityContext RunAsNonRoot

## Steps

1. Create the Pod with the required securityContext:

```bash
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: nonroot-pod
  namespace: q57
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    runAsGroup: 3000
  containers:
  - name: nginx
    image: nginx:latest
EOF
```

**Note:** The Pod may not reach Running state because the nginx image tries to bind to port 80 and write to directories requiring root. The check validates that the securityContext is correctly configured in the spec.

## Verify

```bash
# Check the pod spec
kubectl get pod nonroot-pod -n q57 -o jsonpath='{.spec.securityContext}' | jq .

# Expected output:
# {"fsGroup":null,"runAsGroup":3000,"runAsNonRoot":true,"runAsUser":1000,...}
```
