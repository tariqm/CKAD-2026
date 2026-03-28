# Question 44 – Add Startup Probe to Slow Starting Pod

**Context:** You need to create a pod for an application that takes a long time to start. A startup probe ensures Kubernetes does not kill the pod before it has fully initialized.

## Your Task

1. Create a Pod `slow-start-pod` in namespace `q44` with:
   - Image: `nginx:latest`
   - Container port: 80
2. Add a startup probe:
   - Type: httpGet
   - Path: `/healthz`
   - Port: 80
   - `failureThreshold`: 30
   - `periodSeconds`: 10

## Docs

- [Configure Startup Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-startup-probes)
