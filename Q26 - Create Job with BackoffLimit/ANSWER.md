# Answer 26 – Create Job with BackoffLimit

## Steps

### Step 1: Create the Job

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: batch/v1
kind: Job
metadata:
  name: backup-job
  namespace: q26
spec:
  backoffLimit: 3
  completions: 1
  template:
    spec:
      containers:
      - name: backup
        image: busybox:latest
        command: ["sh", "-c", "echo Running backup && exit 0"]
      restartPolicy: Never
EOF
```

## Verify

```bash
# Check job status
kubectl get job backup-job -n q26

# Verify backoffLimit and completions
kubectl describe job backup-job -n q26 | grep -E "Backoff|Completions"

# Check completed pods
kubectl get pods -n q26 -l job-name=backup-job
```

Expected: Job completes successfully with 1/1 completions.
