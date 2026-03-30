# Question 16 – Add Resource Requests and Limits to Pod

In namespace `q16`, a ResourceQuota exists that sets resource limits for the namespace.

## Your Task

1. Check the ResourceQuota for namespace `q16` to see the limits set
2. Create a Pod named `resource-pod` with:
   - Image: `nginx:latest`
   - Set the CPU and memory limits to **half** of the limits set in the ResourceQuota
   - Set appropriate requests (at least `100m` CPU and `128Mi` memory)

## Docs

- [ResourceQuota](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
- [Resource Management](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)
