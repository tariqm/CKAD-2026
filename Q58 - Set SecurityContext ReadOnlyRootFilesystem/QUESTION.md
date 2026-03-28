# Question 58 – Set SecurityContext ReadOnlyRootFilesystem

**Context:** You need to create a hardened Pod with a read-only root filesystem. The container should still be able to write temporary files to `/tmp`.

## Your Task

1. Create a Pod named `readonly-pod` in namespace `q58` using the `busybox:latest` image with command `["sh", "-c", "sleep 3600"]`.
2. Set the container-level `securityContext` with `readOnlyRootFilesystem: true`.
3. Add an `emptyDir` volume and mount it at `/tmp` so the container can still write temporary files.

## Docs

- [Configure a Security Context for a Pod](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
