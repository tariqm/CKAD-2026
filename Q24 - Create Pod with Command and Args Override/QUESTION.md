# Question 24 – Create Pod with Command and Args Override

**Context:** In Kubernetes, you can override a container's default entrypoint using `command` (equivalent to Docker's ENTRYPOINT) and `args` (equivalent to Docker's CMD).

## Your Task

1. In namespace `q24`, create a Pod named `custom-cmd-pod` with:
   - Image: `busybox:latest`
   - Command: `["sh", "-c"]`
   - Args: `["echo Hello CKAD && sleep 3600"]`

2. The pod should start, print "Hello CKAD", and then stay running (due to the sleep).

## Docs

- [Define a Command and Arguments for a Container](https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/)
