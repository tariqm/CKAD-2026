# Question 18 – Create Pod with Init Container

**Context:** Init containers run before the main application containers start. They are commonly used to wait for dependencies, perform setup tasks, or block until preconditions are met. A Service named `mydb` already exists in namespace `q18`.

## Your Task

1. In namespace `q18`, create a Pod named `app-pod` with:

   - **Init container:**
     - Name: `init-mydb`
     - Image: `busybox:latest`
     - Command: `["sh", "-c", "until nslookup mydb.q18.svc.cluster.local; do echo waiting; sleep 2; done"]`

   - **Main container:**
     - Name: `app`
     - Image: `nginx:latest`

2. The init container should complete successfully (since the `mydb` Service already exists), allowing the main container to start.

## Docs

- [Init Containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)
