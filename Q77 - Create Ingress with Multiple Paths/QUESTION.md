# Question 77 – Create Ingress with Multiple Paths

**Context:**
An Ingress can route traffic to different backend services based on the URL path, enabling a single host to serve multiple applications.

## Your Task

1. Two services already exist in namespace `q77`:
   - `frontend-svc` on port 80
   - `api-svc` on port 80
2. Create an Ingress named `multi-path-ingress` in namespace `q77` that:
   - Uses host `app.example.com`
   - Routes `/frontend` (pathType: `Prefix`) to service `frontend-svc` on port 80
   - Routes `/api` (pathType: `Prefix`) to service `api-svc` on port 80

## Docs

- [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
