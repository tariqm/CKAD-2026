# Question 32 – Create Temporary Debug Pod

**Context:** A backend Service `backend-svc` and Deployment `backend` are already running in namespace `q32`. You need to verify the backend is reachable by creating a temporary debug Pod.

## Your Task

1. Create a Pod named `debug-pod` in namespace `q32` using image `busybox:latest`.
2. The Pod should run the command: `wget -qO- http://backend-svc.q32.svc.cluster.local`
3. Set the Pod's `restartPolicy` to `Never`.

## Docs

- [Debugging Services](https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/)
