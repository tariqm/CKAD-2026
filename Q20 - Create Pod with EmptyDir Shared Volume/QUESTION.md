# Question 20 – Create Pod with EmptyDir Shared Volume

**Context:** An `emptyDir` volume is created when a Pod is assigned to a node and exists as long as the Pod runs. Containers in the same Pod can read and write the same files in an `emptyDir` volume.

## Your Task

1. In namespace `q20`, create a Pod named `shared-vol-pod` with two containers sharing an `emptyDir` volume:

   - **Container 1 (writer):**
     - Name: `writer`
     - Image: `busybox:latest`
     - Command: `["sh", "-c", "while true; do date >> /data/output.txt; sleep 5; done"]`
     - Mount volume `shared-data` at `/data`

   - **Container 2 (reader):**
     - Name: `reader`
     - Image: `busybox:latest`
     - Command: `["sh", "-c", "tail -f /data/output.txt"]`
     - Mount volume `shared-data` at `/data`

   - **Volume:**
     - Name: `shared-data`
     - Type: `emptyDir`

## Docs

- [Volumes - emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir)
