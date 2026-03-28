# Question 57 – Set SecurityContext RunAsNonRoot

**Context:** You need to create a Pod that enforces running as a non-root user for security hardening.

**Note:** The nginx image normally runs as root and may not start successfully with these constraints. The goal is to correctly configure the securityContext in the Pod spec.

## Your Task

1. Create a Pod named `nonroot-pod` in namespace `q57` using the `nginx:latest` image.
2. Set the pod-level `securityContext` with:
   - `runAsNonRoot: true`
   - `runAsUser: 1000`
   - `runAsGroup: 3000`

## Docs

- [Configure a Security Context for a Pod](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
