# Question 2 – Create CronJob with Schedule and History Limits

Create a CronJob named `backup-job` in namespace `default` with the following specifications:

- Schedule: Run every 30 minutes (`*/30 * * * *`)
- Image: `busybox:latest`
- Container command: `echo "Backup completed"`
- Set `successfulJobsHistoryLimit: 3`
- Set `failedJobsHistoryLimit: 2`
- Set `activeDeadlineSeconds: 300`
- Use `restartPolicy: Never`

**Tip:** Use `kubectl explain cronjob.spec` to find the correct field names.

## Docs

- [CronJobs](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)
