# Answer 68 – Use Downward API Volume

## Step-by-step Solution

### Step 1: Create the pod with a Downward API volume

```bash
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: downward-vol-pod
  namespace: q68
  labels:
    app: downward-demo
    tier: backend
spec:
  containers:
  - name: downward-vol-pod
    image: busybox:latest
    command: ["sh", "-c", "cat /etc/podinfo/labels; sleep 3600"]
    volumeMounts:
    - name: podinfo
      mountPath: /etc/podinfo
  volumes:
  - name: podinfo
    downwardAPI:
      items:
      - path: "labels"
        fieldRef:
          fieldPath: metadata.labels
EOF
```

## Verify

```bash
# Check pod is running
kubectl get pod downward-vol-pod -n q68

# Check the labels file content
kubectl exec downward-vol-pod -n q68 -- cat /etc/podinfo/labels
```
