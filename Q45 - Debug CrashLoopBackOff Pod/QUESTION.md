# Question 45 – Debug CrashLoopBackOff Pod

**Context:** A pod `crashing-pod` in namespace `q45` is in `CrashLoopBackOff` state because its command exits immediately with an error code.

## Your Task

1. Investigate why the pod `crashing-pod` in namespace `q45` is crashing.
2. Fix the pod by changing the command to `["sh", "-c", "echo starting; sleep 3600"]` so it stays running.
3. You must delete and recreate the pod (pod specs are immutable).

## Docs

- [Debug Running Pods](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/)
