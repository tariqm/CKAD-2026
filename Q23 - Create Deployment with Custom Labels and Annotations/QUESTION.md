# Question 23 – Create Deployment with Custom Labels and Annotations

**Context:** Labels are key/value pairs used to organize and select resources. Annotations attach non-identifying metadata to objects.

## Your Task

1. In namespace `q23`, create a Deployment named `labeled-app` with:
   - Replicas: `3`
   - Image: `nginx:latest`
   - Pod template labels:
     - `app: labeled-app`
     - `tier: frontend`
     - `env: staging`
   - Pod template annotation:
     - `description: "Frontend staging deployment"`

2. Make sure the Deployment's selector matches the pod template labels appropriately.

## Docs

- [Labels and Selectors](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)
- [Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/)
