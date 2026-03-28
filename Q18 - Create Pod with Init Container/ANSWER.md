# Answer 18 – Create Pod with Init Container

## Steps

### 1. Create the Pod with an init container

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: app-pod
  namespace: q18
spec:
  initContainers:
  - name: init-mydb
    image: busybox:latest
    command: ["sh", "-c", "until nslookup mydb.q18.svc.cluster.local; do echo waiting; sleep 2; done"]
  containers:
  - name: app
    image: nginx:latest
EOF
```

## Verify

```bash
# Check pod status (init container should complete, main container should be Running)
kubectl get pod app-pod -n q18

# Check init container status
kubectl describe pod app-pod -n q18 | grep -A 10 "Init Containers:"

# Check init container logs
kubectl logs app-pod -n q18 -c init-mydb
```
