# Question 6 – Create Canary Deployment with Manual Traffic Split

In namespace `q06`, the following resources exist:

- Deployment `web-app` with 5 replicas, labels `app=webapp, version=v1`
- Service `web-service` with selector `app=webapp`

## Your Task

1. Scale Deployment `web-app` to 8 replicas (80% of 10 total)
2. Create a new Deployment `web-app-canary` with 2 replicas, labels `app=webapp, version=v2`
3. Both Deployments should be selected by `web-service`
4. Verify the traffic split using the provided test command (if available)

**Note:** This is a manual canary pattern where traffic is split based on replica counts.

## Docs

- [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
