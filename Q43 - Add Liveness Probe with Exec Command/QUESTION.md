# Question 43 – Add Liveness Probe with Exec Command

**Context:** You need to create a pod with an exec-based liveness probe that checks for the existence of a file to determine if the container is healthy.

## Your Task

1. Create a Pod `liveness-exec-pod` in namespace `q43` with:
   - Image: `busybox:latest`
   - Command: `["sh", "-c", "touch /tmp/healthy; sleep 3600"]`
2. Add a liveness probe:
   - Type: exec
   - Command: `cat /tmp/healthy`
   - `initialDelaySeconds`: 5
   - `periodSeconds`: 10

## Docs

- [Configure Liveness Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-a-liveness-command)
