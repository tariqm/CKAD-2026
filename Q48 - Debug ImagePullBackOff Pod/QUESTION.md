# Question 48 – Debug ImagePullBackOff Pod

**Context:** A pod `bad-image-pod` in namespace `q48` is stuck in `ImagePullBackOff` status because it references a non-existent container image tag.

## Your Task

1. Check the status of pod `bad-image-pod` in namespace `q48`.
2. Use `kubectl describe` to identify the image pull error.
3. Fix the pod by changing the image to `nginx:latest`.
4. Since pod image fields are immutable, delete the existing pod and recreate it with the correct image.

## Docs

- https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/
