# Question 26 – Create Job with BackoffLimit

**Context:** Kubernetes Jobs can be configured with a `backoffLimit` to control how many times a failed Pod is retried before the Job is considered failed. This is useful for tasks that may encounter transient failures.

## Your Task

1. In namespace `q26`, create a Job named `backup-job` with the following configuration:

   - Image: `busybox:latest`
   - Command: `["sh", "-c", "echo Running backup && exit 0"]`
   - backoffLimit: `3`
   - completions: `1`
   - restartPolicy: `Never`

## Docs

- [Jobs](https://kubernetes.io/docs/concepts/workloads/controllers/job/)
- [Job backoffLimit](https://kubernetes.io/docs/concepts/workloads/controllers/job/#pod-backoff-failure-policy)
