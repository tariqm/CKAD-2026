# Answer 59 – Create Pod with fsGroup SecurityContext

## Steps

1. Create the Pod with fsGroup and runAsUser:

```bash
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: fsgroup-pod
  namespace: q59
spec:
  securityContext:
    fsGroup: 2000
    runAsUser: 1000
  containers:
  - name: busybox
    image: busybox:latest
    command: ["sh", "-c", "sleep 3600"]
    volumeMounts:
    - name: data-volume
      mountPath: /data
  volumes:
  - name: data-volume
    emptyDir: {}
EOF
```

## Verify

```bash
# Check the pod is running
kubectl get pod fsgroup-pod -n q59

# Verify fsGroup and runAsUser in spec
kubectl get pod fsgroup-pod -n q59 -o jsonpath='{.spec.securityContext}' | jq .

# Check that files in /data are owned by group 2000
kubectl exec fsgroup-pod -n q59 -- ls -la /data
kubectl exec fsgroup-pod -n q59 -- id
```
