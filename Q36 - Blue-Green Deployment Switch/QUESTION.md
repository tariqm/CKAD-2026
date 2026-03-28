# Question 36 – Blue-Green Deployment Switch

**Context:** A blue-green deployment strategy is in place with two Deployments (`app-blue` running `nginx:1.20` and `app-green` running `nginx:1.25`) in namespace `q36`. A Service named `app-svc` currently routes traffic to the **blue** version.

## Your Task

1. Verify that the Service `app-svc` currently selects the **blue** Deployment.
2. Update the Service `app-svc` so that it routes traffic to the **green** Deployment instead.

## Docs

- [Services](https://kubernetes.io/docs/concepts/services-networking/service/)
- [Blue-Green Deployments](https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/#canary-deployments)
