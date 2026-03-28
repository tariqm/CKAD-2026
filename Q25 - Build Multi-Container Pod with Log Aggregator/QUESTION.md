# Question 25 – Build Multi-Container Pod with Log Aggregator

**Context:** Multi-container Pods can share volumes to enable patterns like log aggregation, where one container generates logs and another reads or processes them.

## Your Task

1. In namespace `q25`, create a Pod named `log-aggregator` with **two containers** and a shared volume:

   - **Log writer container:**
     - Name: `writer`
     - Image: `busybox:latest`
     - Command: `["sh", "-c", "while true; do echo $(date) INFO log entry >> /var/log/app/output.log; sleep 5; done"]`
     - Mount the shared volume at `/var/log/app`

   - **Log reader container:**
     - Name: `reader`
     - Image: `busybox:latest`
     - Command: `["sh", "-c", "tail -f /var/log/app/output.log"]`
     - Mount the shared volume at `/var/log/app`

   - **Volume:**
     - Name: `shared-logs`
     - Type: `emptyDir`

2. Verify both containers are running and the reader can see logs from the writer.

## Docs

- [Multi-container Pods](https://kubernetes.io/docs/concepts/workloads/pods/#how-pods-manage-multiple-containers)
- [Volumes](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir)
