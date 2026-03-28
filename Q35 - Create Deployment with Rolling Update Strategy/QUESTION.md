# Question 35 – Create Deployment with Rolling Update Strategy

**Context:** You need to create a Deployment with a specific rolling update strategy to control how updates are rolled out.

## Your Task

1. Create a Deployment named `rolling-app` in namespace `q35`.
2. Set the replica count to `5`.
3. Use the image `nginx:1.20`.
4. Set the strategy type to `RollingUpdate`.
5. Configure `maxSurge` to `2` and `maxUnavailable` to `1`.

## Docs

- [Deployments - Rolling Update](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-update-deployment)
