# Answer 53 – Create Logging Sidecar Container

## Steps

### 1. Create the Pod with app and sidecar containers

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: app-with-sidecar-logging
  namespace: q53
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["sh", "-c", "while true; do echo \"$(date) - app log entry\" >> /var/log/app.log; sleep 5; done"]
    volumeMounts:
    - name: log-vol
      mountPath: /var/log
  - name: sidecar
    image: busybox:1.36
    command: ["sh", "-c", "tail -f /var/log/app.log"]
    volumeMounts:
    - name: log-vol
      mountPath: /var/log
  volumes:
  - name: log-vol
    emptyDir: {}
EOF
```

## Verify

```bash
# Check the pod is running
kubectl get pod app-with-sidecar-logging -n q53

# Check the sidecar is streaming logs
kubectl logs app-with-sidecar-logging -n q53 -c sidecar

# Confirm both containers are present
kubectl get pod app-with-sidecar-logging -n q53 -o jsonpath='{.spec.containers[*].name}'
```
