# Question 38 – Create Deployment with Change Cause Annotation

**Context:** You need to create a Deployment that tracks its rollout history with descriptive change-cause annotations, making it easy to understand why each revision was created.

## Your Task

1. Create a Deployment `tracked-app` in namespace `q38` with 3 replicas using image `nginx:1.20`.
2. Annotate the Deployment with `kubernetes.io/change-cause="Initial deployment with nginx:1.20"`.
3. Update the image to `nginx:1.25`.
4. Annotate the Deployment with `kubernetes.io/change-cause="Updated to nginx:1.25"`.
5. Verify rollout history shows multiple revisions.

## Docs

- [Deployments - Rollout History](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#checking-rollout-history-of-a-deployment)
