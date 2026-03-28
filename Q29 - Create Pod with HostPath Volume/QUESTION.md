# Question 29 – Create Pod with HostPath Volume

**Context:** You need to create a Pod that mounts a directory from the host node's filesystem into the container.

## Your Task

1. Create a Pod named `hostpath-pod` in namespace `q29`.
2. Use the image `nginx:latest`.
3. Add a `hostPath` volume with the path `/data/web` and type `DirectoryOrCreate`.
4. Mount the volume at `/usr/share/nginx/html` inside the container.

## Docs

- [Volumes - hostPath](https://kubernetes.io/docs/concepts/storage/volumes/#hostpath)
