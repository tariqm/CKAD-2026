# Question 71 – Expose Deployment via kubectl expose

**Context:**
The `kubectl expose` command is a quick imperative way to create a service for an existing resource such as a deployment or pod.

## Your Task

1. A deployment named `api-deploy` already exists in namespace `q71` with pods listening on port 80.
2. Use `kubectl expose` to create a service named `api-svc` in namespace `q71` that:
   - Exposes the deployment `api-deploy`
   - Has service port `8080`
   - Targets container port `80`
   - Uses type `ClusterIP`

## Docs

- [kubectl expose](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_expose/)
