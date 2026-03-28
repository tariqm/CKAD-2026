# Question 51 – Debug Pod with Wrong Command

**Context:** A pod `wrong-cmd-pod` in namespace `q51` is crashing because it was created with an incorrect command that references a non-existent binary.

## Your Task

1. Check the status of pod `wrong-cmd-pod` in namespace `q51`.
2. Use `kubectl describe` and `kubectl logs` to diagnose why the pod is crashing.
3. The correct command should be `["nginx", "-g", "daemon off;"]`.
4. Delete the broken pod and recreate it with the correct command.

## Docs

- https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/
