# Question 40 – Rolling Restart Deployment

**Context:** A Deployment `restart-app` exists in namespace `q40` with 3 replicas. You need to perform a rolling restart to refresh all pods without changing the Deployment spec.

## Your Task

1. Perform a rolling restart of Deployment `restart-app` in namespace `q40`.
2. Wait for the rollout to complete successfully.
3. Verify the rollout history shows a new revision.

## Docs

- [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
