# Question 69 – Create Docker Registry Secret

**Context:**
Private container registries require authentication. Kubernetes uses docker-registry type secrets to store credentials and pull images from private registries.

## Your Task

1. Create a secret named `my-registry-secret` of type `docker-registry` in namespace `q69` with the following details:
   - Docker server: `https://registry.example.com`
   - Username: `admin`
   - Password: `secret123`
   - Email: `admin@example.com`
2. Create a pod named `registry-pod` in namespace `q69` using image `nginx:latest` that uses `my-registry-secret` as an `imagePullSecret`.

## Docs

- [Pull an Image from a Private Registry](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/)
