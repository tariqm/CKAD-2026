# Question 62 – Use Projected Volume with Secret and ConfigMap

**Context:** A Secret named `app-secret` and a ConfigMap named `app-config` already exist in namespace `q62`. You need to create a Pod that mounts both into the same directory using a projected volume.

## Your Task

1. Create a Pod named `projected-pod` in namespace `q62` using image `nginx:1.25`.
2. Define a projected volume named `combined-vol` that includes:
   - The Secret `app-secret`
   - The ConfigMap `app-config`
3. Mount the projected volume at `/etc/app-config` in the container.

## Docs

- [Projected Volumes](https://kubernetes.io/docs/concepts/storage/projected-volumes/)
