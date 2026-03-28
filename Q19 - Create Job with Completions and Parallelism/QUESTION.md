# Question 19 – Create Job with Completions and Parallelism

**Context:** Kubernetes Jobs create one or more Pods and ensure they successfully terminate. You can control how many times a Job runs (completions) and how many Pods run simultaneously (parallelism).

## Your Task

1. In namespace `q19`, create a Job named `batch-job` with the following configuration:

   - Image: `busybox:latest`
   - Command: `["sh", "-c", "echo Processing batch item"]`
   - Completions: `5` (the Job must complete 5 times)
   - Parallelism: `2` (run up to 2 Pods at a time)
   - restartPolicy: `Never`

## Docs

- [Jobs](https://kubernetes.io/docs/concepts/workloads/controllers/job/)
