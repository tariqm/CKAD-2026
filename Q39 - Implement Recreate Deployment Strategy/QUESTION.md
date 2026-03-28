# Question 39 – Implement Recreate Deployment Strategy

**Context:** Some applications cannot handle running multiple versions simultaneously. You need to create a Deployment that uses the `Recreate` strategy, which terminates all existing pods before creating new ones.

## Your Task

1. Create a Deployment `recreate-app` in namespace `q39` with:
   - 3 replicas
   - Image: `nginx:latest`
   - Strategy type: `Recreate`

## Docs

- [Deployment Strategy](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy)
