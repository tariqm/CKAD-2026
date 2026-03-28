# Question 59 – Create Pod with fsGroup SecurityContext

**Context:** You need to create a Pod where all files created in mounted volumes are owned by a specific group. This is useful for shared storage scenarios.

## Your Task

1. Create a Pod named `fsgroup-pod` in namespace `q59` using the `busybox:latest` image with command `["sh", "-c", "sleep 3600"]`.
2. Set the pod-level `securityContext` with:
   - `fsGroup: 2000`
   - `runAsUser: 1000`
3. Add an `emptyDir` volume and mount it at `/data`.

## Docs

- [Configure a Security Context for a Pod](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
