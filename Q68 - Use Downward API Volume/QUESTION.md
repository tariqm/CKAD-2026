# Question 68 – Use Downward API Volume

**Context:**
The Downward API can also expose pod metadata through volume files, allowing applications to read pod information from the filesystem.

## Your Task

1. Create a pod named `downward-vol-pod` in namespace `q68` using image `busybox:latest`.
2. Set the pod command to: `["sh", "-c", "cat /etc/podinfo/labels; sleep 3600"]`
3. Define a volume of type `downwardAPI` that exposes `metadata.labels` via a file named `labels`.
4. Mount the volume at `/etc/podinfo` in the container.

## Docs

- [Expose Pod Information to Containers Through Files](https://kubernetes.io/docs/tasks/inject-data-application/downward-api-volume-expose-pod-information/)
