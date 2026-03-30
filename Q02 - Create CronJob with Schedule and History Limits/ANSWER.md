# Answer 2 – Create CronJob with Schedule and History Limits

```bash
cat <<EOF | kubectl apply -f -
apiVersion: batch/v1
kind: CronJob
metadata:
  name: backup-job
  namespace: q02
spec:
  schedule: "*/30 * * * *"
  successfulJobsHistoryLimit: 3
  failedJobsHistoryLimit: 2
  jobTemplate:
    spec:
      activeDeadlineSeconds: 300
      template:
        spec:
          restartPolicy: Never
          containers:
            - name: backup
              image: busybox:latest
              command: ["/bin/sh", "-c"]
              args: ["echo Backup completed"]
EOF
```

## Verify

```bash
kubectl get cronjob backup-job
kubectl describe cronjob backup-job
kubectl create job backup-job-test --from=cronjob/backup-job
kubectl logs job/backup-job-test
```
