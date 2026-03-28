# Question 31 – Create Deployment from Scratch with Port

**Context:** You need to create a Deployment for a web frontend application from scratch with specific replica count, image, port, and labels.

## Your Task

1. Create a Deployment named `web-frontend` in namespace `q31`.
2. Set the replica count to `4`.
3. Use the image `httpd:latest`.
4. Expose container port `80`.
5. Apply the labels `app=web-frontend` and `tier=frontend` to the Pod template.

## Docs

- [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
