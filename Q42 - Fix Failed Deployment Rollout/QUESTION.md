# Question 42 – Fix Failed Deployment Rollout

**Context:** A Deployment `broken-deploy` in namespace `q42` is failing because it references an invalid image tag. The pods are stuck in `ImagePullBackOff` state.

## Your Task

1. Identify why the Deployment `broken-deploy` in namespace `q42` is failing.
2. Fix the Deployment by updating the image to `nginx:latest`.
3. Ensure the rollout completes successfully.

## Docs

- [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
