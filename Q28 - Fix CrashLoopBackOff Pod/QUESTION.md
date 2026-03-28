# Question 28 – Fix CrashLoopBackOff Pod

**Context:** A pod `crashing-pod` in namespace `q28` is in `CrashLoopBackOff` state. The container's command references a missing file and exits with an error code.

## Your Task

1. Investigate why the pod `crashing-pod` in namespace `q28` is crashing.
2. Fix the pod by changing the command to `["sh", "-c", "echo starting app; sleep 3600"]` so it stays running.
3. You must delete and recreate the pod (pod specs are immutable).

## Docs

- [Debug Running Pods](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/)
- [Pod Lifecycle](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/)
