# Question 61 – Create LimitRange in Namespace

**Context:** You need to enforce default resource requests and limits for containers in a namespace using a LimitRange.

## Your Task

1. Create a LimitRange named `default-limits` in namespace `q61`.
2. Set the following defaults for containers:
   - Default CPU request: `100m`
   - Default CPU limit: `500m`
   - Default memory request: `128Mi`
   - Default memory limit: `512Mi`

## Docs

- [Limit Ranges](https://kubernetes.io/docs/concepts/policy/limit-range/)
