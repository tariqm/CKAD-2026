# Answer 69 – Create Docker Registry Secret

## Step-by-step Solution

### Step 1: Create the docker-registry secret

```bash
kubectl create secret docker-registry my-registry-secret \
  --namespace=q69 \
  --docker-server=https://registry.example.com \
  --docker-username=admin \
  --docker-password=secret123 \
  --docker-email=admin@example.com
```

### Step 2: Create a pod that uses the imagePullSecret

```bash
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: registry-pod
  namespace: q69
spec:
  containers:
  - name: registry-pod
    image: nginx:latest
  imagePullSecrets:
  - name: my-registry-secret
EOF
```

## Verify

```bash
# Check the secret exists and has the right type
kubectl get secret my-registry-secret -n q69

# Check the pod has imagePullSecrets configured
kubectl get pod registry-pod -n q69 -o jsonpath='{.spec.imagePullSecrets}'
```
