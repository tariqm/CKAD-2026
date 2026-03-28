# Question 50 – Create Pod with All Three Probes

**Context:** Namespace `q50` is available. You need to create a pod with all three types of health probes configured.

## Your Task

1. Create a pod named `triple-probe-pod` in namespace `q50` using image `nginx:latest` with container port `80`.
2. Configure a **startup probe**: httpGet on path `/` port `80`, with `failureThreshold: 30` and `periodSeconds: 10`.
3. Configure a **liveness probe**: httpGet on path `/` port `80`, with `periodSeconds: 15`.
4. Configure a **readiness probe**: httpGet on path `/` port `80`, with `periodSeconds: 5`.

## Docs

- https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/
