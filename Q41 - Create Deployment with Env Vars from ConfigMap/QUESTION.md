# Question 41 – Create Deployment with Env Vars from ConfigMap

**Context:** A ConfigMap `app-config` exists in namespace `q41` with keys `APP_ENV` and `APP_DEBUG`. You need to create a Deployment that loads all keys from this ConfigMap as environment variables.

## Your Task

1. Create a Deployment `env-app` in namespace `q41` with:
   - 2 replicas
   - Image: `nginx:latest`
2. Load ALL keys from ConfigMap `app-config` as environment variables using `envFrom`.

## Docs

- [Configure a Pod to Use a ConfigMap](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#configure-all-key-value-pairs-in-a-configmap-as-container-environment-variables)
