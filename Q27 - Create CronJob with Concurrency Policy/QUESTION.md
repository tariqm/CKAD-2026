# Question 27 – Create CronJob with Concurrency Policy

**Context:** CronJobs run Jobs on a repeating schedule. The `concurrencyPolicy` field controls whether new Jobs are allowed to run concurrently with existing ones. Setting it to `Forbid` prevents a new Job from starting if the previous one is still running.

## Your Task

1. In namespace `q27`, create a CronJob named `report-gen` with the following configuration:

   - Image: `busybox:latest`
   - Command: `["sh", "-c", "echo Generating report && sleep 30"]`
   - Schedule: `*/5 * * * *` (every 5 minutes)
   - concurrencyPolicy: `Forbid`
   - restartPolicy: `Never`

## Docs

- [CronJobs](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)
- [Concurrency Policy](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#concurrency-policy)
