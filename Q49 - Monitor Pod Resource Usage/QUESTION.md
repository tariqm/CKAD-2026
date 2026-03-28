# Question 49 – Monitor Pod Resource Usage

**Context:** A Deployment `monitored-app` with 3 replicas is running in namespace `q49`. You need to capture the resource usage of the pods.

## Your Task

1. Attempt to get the resource usage of pods in namespace `q49` using `kubectl top pods -n q49`.
2. If the metrics-server is available, save the output to `/root/q49-top.txt`.
3. If the metrics-server is NOT available (command fails), save the output of `kubectl get pods -n q49 -o wide` to `/root/q49-top.txt` instead.
4. Ensure the file is not empty.

## Docs

- https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-usage-monitoring/
