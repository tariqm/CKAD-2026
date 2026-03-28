# Question 67 – Use Downward API Environment Variables

**Context:**
The Downward API allows pods to access information about themselves through environment variables without coupling to the Kubernetes API.

## Your Task

1. Create a pod named `downward-env-pod` in namespace `q67` using image `busybox:latest`.
2. Set the pod command to: `["sh", "-c", "echo POD_NAME=$POD_NAME POD_IP=$POD_IP NODE_NAME=$NODE_NAME; sleep 3600"]`
3. Configure the following environment variables using the Downward API:
   - `POD_NAME` from `fieldRef` → `metadata.name`
   - `POD_IP` from `fieldRef` → `status.podIP`
   - `NODE_NAME` from `fieldRef` → `spec.nodeName`

## Docs

- [Expose Pod Information to Containers Through Environment Variables](https://kubernetes.io/docs/tasks/inject-data-application/environment-variable-expose-pod-information/)
