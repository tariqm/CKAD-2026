# Question 47 – Debug Pending Pod Due to Resource Constraints

**Context:** A namespace `q47` has a ResourceQuota that limits total CPU and memory usage. An existing pod is already consuming most of the quota. A pod spec at `/root/pending-pod.yaml` attempts to request more resources than the remaining quota allows, so it will be rejected.

## Your Task

1. Examine the ResourceQuota in namespace `q47` using `kubectl describe resourcequota -n q47`.
2. Check the existing pod's resource usage against the quota.
3. Review the pod spec at `/root/pending-pod.yaml` and understand why it would be rejected.
4. Create a new pod named `fixed-pod` in namespace `q47` based on the spec, but adjust the resource requests and limits to fit within the remaining quota (CPU request must be <= 100m).
5. Ensure the pod is successfully created (not rejected by quota).

## Docs

- https://kubernetes.io/docs/concepts/policy/resource-quotas/
- https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/
