# Answer 19 – Create Job with Completions and Parallelism

## Steps

### 1. Create the Job

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: batch/v1
kind: Job
metadata:
  name: batch-job
  namespace: q19
spec:
  completions: 5
  parallelism: 2
  template:
    spec:
      containers:
      - name: batch
        image: busybox:latest
        command: ["sh", "-c", "echo Processing batch item"]
      restartPolicy: Never
EOF
```

## Verify

```bash
# Check job status
kubectl get job batch-job -n q19

# Watch pods being created
kubectl get pods -n q19 -l job-name=batch-job

# Check completions and parallelism
kubectl describe job batch-job -n q19 | grep -E "Completions|Parallelism"
```
