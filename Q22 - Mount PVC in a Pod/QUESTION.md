# Question 22 – Mount PVC in a Pod

**Context:** A PersistentVolume `data-pv` and PersistentVolumeClaim `data-pvc` have already been created in namespace `q22`. Your task is to create a Pod that uses this PVC.

## Your Task

1. In namespace `q22`, create a Pod named `pvc-pod` with:
   - Image: `nginx:latest`
   - Mount the existing PVC `data-pvc` at path `/usr/share/nginx/html`

## Docs

- [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
- [Configure a Pod to Use a PersistentVolume for Storage](https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/)
