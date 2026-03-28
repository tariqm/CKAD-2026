# Answer 25 – Build Multi-Container Pod with Log Aggregator

## Steps

### Step 1: Create the multi-container Pod

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: log-aggregator
  namespace: q25
spec:
  containers:
  - name: writer
    image: busybox:latest
    command: ["sh", "-c", "while true; do echo $(date) INFO log entry >> /var/log/app/output.log; sleep 5; done"]
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log/app
  - name: reader
    image: busybox:latest
    command: ["sh", "-c", "tail -f /var/log/app/output.log"]
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log/app
  volumes:
  - name: shared-logs
    emptyDir: {}
EOF
```

## Verify

```bash
# Check pod status
kubectl get pod log-aggregator -n q25

# Verify both containers are running
kubectl describe pod log-aggregator -n q25 | grep -A2 "State:"

# Check that the reader sees logs from the writer
kubectl logs log-aggregator -n q25 -c reader
```

Expected: Pod is in `Running` state with 2/2 containers ready. The reader container logs show entries written by the writer.
