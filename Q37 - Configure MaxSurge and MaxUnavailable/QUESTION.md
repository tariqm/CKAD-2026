# Question 37 – Configure MaxSurge and MaxUnavailable

**Context:** A Deployment `strategy-app` with 4 replicas exists in namespace `q37` using the default rolling update strategy. You need to configure it for zero-downtime deployments and then update the image.

## Your Task

1. Update the Deployment `strategy-app` in namespace `q37` to use a `RollingUpdate` strategy with:
   - `maxSurge: 1`
   - `maxUnavailable: 0`
2. Update the container image from `nginx:1.20` to `nginx:1.25`.
3. Verify the rollout completes successfully.

## Docs

- [Deployment Strategy](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy)
