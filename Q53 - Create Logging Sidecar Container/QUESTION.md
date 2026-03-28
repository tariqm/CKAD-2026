# Question 53 – Create Logging Sidecar Container

**Context:** You need to create a multi-container Pod where one container generates application logs and a sidecar container reads and streams those logs.

## Your Task

1. Create a Pod named `app-with-sidecar-logging` in namespace `q53`.
2. Add a container named `app` using image `busybox:1.36` that writes logs to a shared volume:
   - Command: `sh -c 'while true; do echo "$(date) - app log entry" >> /var/log/app.log; sleep 5; done'`
3. Add a sidecar container named `sidecar` using image `busybox:1.36` that tails the log file:
   - Command: `sh -c 'tail -f /var/log/app.log'`
4. Both containers must mount a shared volume named `log-vol` at `/var/log`.

## Docs

- [Sidecar Containers](https://kubernetes.io/docs/concepts/workloads/pods/sidecar-containers/)
- [Volumes - emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir)
