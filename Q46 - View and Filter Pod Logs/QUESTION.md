# Question 46 – View and Filter Pod Logs

**Context:** A Deployment `log-app` and a Pod `error-pod` exist in namespace `q46`. The `error-pod` outputs error messages that you need to capture to a file.

## Your Task

1. Capture the logs from pod `error-pod` in namespace `q46` to the file `/root/q46-errors.txt`.

```bash
kubectl logs error-pod -n q46 > /root/q46-errors.txt
```

## Docs

- [Logging](https://kubernetes.io/docs/concepts/cluster-administration/logging/)
