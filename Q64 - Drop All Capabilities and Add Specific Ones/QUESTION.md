# Question 64 – Drop All Capabilities and Add Specific Ones

**Context:** You need to create a Pod that follows the principle of least privilege by dropping all Linux capabilities and only adding back the ones that are needed.

## Your Task

1. Create a Pod named `secure-pod` in namespace `q64` using image `nginx:1.25`.
2. In the container's security context, drop **ALL** capabilities.
3. Add back only the `NET_BIND_SERVICE` capability.

## Docs

- [Set capabilities for a Container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-capabilities-for-a-container)
