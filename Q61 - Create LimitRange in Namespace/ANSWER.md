# Answer 61 – Create LimitRange in Namespace

## Steps

### 1. Create the LimitRange

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: LimitRange
metadata:
  name: default-limits
  namespace: q61
spec:
  limits:
  - type: Container
    default:
      cpu: 500m
      memory: 512Mi
    defaultRequest:
      cpu: 100m
      memory: 128Mi
EOF
```

## Verify

```bash
# Check the LimitRange
kubectl get limitrange default-limits -n q61

# See detailed limits
kubectl describe limitrange default-limits -n q61

# Test by creating a pod without resource specs
kubectl run test-pod --image=nginx -n q61
kubectl get pod test-pod -n q61 -o jsonpath='{.spec.containers[0].resources}'
```
