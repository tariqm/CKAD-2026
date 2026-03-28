# Question 30 – Create Deployment with Multiple Containers

**Context:** You need to create a Deployment that runs multiple containers in each Pod, a common pattern for adding sidecars alongside the main application.

## Your Task

1. Create a Deployment named `multi-deploy` in namespace `q30` with `2` replicas.
2. The first container should be named `web`, use image `nginx:latest`, and expose port `80`.
3. The second container should be named `metrics`, use image `busybox:latest`, and run the command: `while true; do echo metrics; sleep 10; done`.

## Docs

- [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
