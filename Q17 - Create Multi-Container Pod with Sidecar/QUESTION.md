# Question 17 – Create Multi-Container Pod with Sidecar

**Context:** Multi-container Pods allow containers to share resources and communicate via localhost. A common pattern is the sidecar, where a helper container runs alongside the main application container.

## Your Task

1. In namespace `q17`, create a Pod named `web-with-sidecar` with **two containers** and a shared volume:

   - **Main container:**
     - Name: `nginx`
     - Image: `nginx:latest`
     - Port: `80`
     - Mount the shared volume at `/var/log/nginx`

   - **Sidecar container:**
     - Name: `sidecar`
     - Image: `busybox:latest`
     - Command: `["sh", "-c", "while true; do wget -q -O - http://localhost:80 >> /var/log/nginx/access.log; sleep 5; done"]`
     - Mount the shared volume at `/var/log/nginx`

   - **Volume:**
     - Name: `shared-logs`
     - Type: `emptyDir`

2. Verify both containers are running.

## Docs

- [Multi-container Pods](https://kubernetes.io/docs/concepts/workloads/pods/#how-pods-manage-multiple-containers)
