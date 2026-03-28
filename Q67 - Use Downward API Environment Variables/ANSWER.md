# Answer 67 – Use Downward API Environment Variables

## Step-by-step Solution

### Step 1: Create the pod with Downward API env vars

```bash
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: downward-env-pod
  namespace: q67
spec:
  containers:
  - name: downward-env-pod
    image: busybox:latest
    command: ["sh", "-c", "echo POD_NAME=$POD_NAME POD_IP=$POD_IP NODE_NAME=$NODE_NAME; sleep 3600"]
    env:
    - name: POD_NAME
      valueFrom:
        fieldRef:
          fieldPath: metadata.name
    - name: POD_IP
      valueFrom:
        fieldRef:
          fieldPath: status.podIP
    - name: NODE_NAME
      valueFrom:
        fieldRef:
          fieldPath: spec.nodeName
EOF
```

## Verify

```bash
# Check pod is running
kubectl get pod downward-env-pod -n q67

# Check env vars are populated
kubectl logs downward-env-pod -n q67

# Or exec into the pod
kubectl exec downward-env-pod -n q67 -- env | grep -E "POD_NAME|POD_IP|NODE_NAME"
```
