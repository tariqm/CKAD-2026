# Answer 58 – Set SecurityContext ReadOnlyRootFilesystem

## Steps

1. Create the Pod with readOnlyRootFilesystem and an emptyDir for /tmp:

```bash
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: readonly-pod
  namespace: q58
spec:
  containers:
  - name: busybox
    image: busybox:latest
    command: ["sh", "-c", "sleep 3600"]
    securityContext:
      readOnlyRootFilesystem: true
    volumeMounts:
    - name: tmp-volume
      mountPath: /tmp
  volumes:
  - name: tmp-volume
    emptyDir: {}
EOF
```

## Verify

```bash
# Check the pod is running
kubectl get pod readonly-pod -n q58

# Verify readOnlyRootFilesystem
kubectl get pod readonly-pod -n q58 -o jsonpath='{.spec.containers[0].securityContext.readOnlyRootFilesystem}'

# Test writing to /tmp (should succeed)
kubectl exec readonly-pod -n q58 -- sh -c "echo test > /tmp/test.txt && cat /tmp/test.txt"

# Test writing to / (should fail)
kubectl exec readonly-pod -n q58 -- sh -c "echo test > /test.txt" || echo "Write to / failed as expected"
```
