# Question 60 – Create ResourceQuota in Namespace

**Context:** You need to enforce resource consumption limits in a namespace by creating a ResourceQuota.

## Your Task

1. Create a ResourceQuota named `compute-quota` in namespace `q60`.
2. Set the following limits:
   - CPU requests: `1`
   - CPU limits: `2`
   - Memory requests: `1Gi`
   - Memory limits: `2Gi`

## Docs

- [Resource Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
