# Answer 27 – Create CronJob with Concurrency Policy

## Steps

### Step 1: Create the CronJob

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: batch/v1
kind: CronJob
metadata:
  name: report-gen
  namespace: q27
spec:
  schedule: "*/5 * * * *"
  concurrencyPolicy: Forbid
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: report
            image: busybox:latest
            command: ["sh", "-c", "echo Generating report && sleep 30"]
          restartPolicy: Never
EOF
```

## Verify

```bash
# Check CronJob exists
kubectl get cronjob report-gen -n q27

# Verify schedule and concurrency policy
kubectl describe cronjob report-gen -n q27 | grep -E "Schedule|Concurrency"
```

Expected: CronJob exists with schedule `*/5 * * * *` and concurrencyPolicy `Forbid`.
