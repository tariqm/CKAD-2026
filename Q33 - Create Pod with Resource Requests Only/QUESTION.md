# Question 33 – Create Pod with Resource Requests Only

**Context:** You need to create a Pod that specifies resource requests but does not set any resource limits. This is a common pattern when you want the scheduler to place the Pod appropriately but allow it to burst above its request if resources are available.

## Your Task

1. Create a Pod named `request-pod` in namespace `q33`.
2. Use the image `nginx:latest`.
3. Set resource requests: CPU `250m`, memory `128Mi`.
4. Do **NOT** set any resource limits.

## Docs

- [Resource Management for Pods and Containers](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)
