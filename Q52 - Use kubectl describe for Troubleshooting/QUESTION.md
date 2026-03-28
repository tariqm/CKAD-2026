# Question 52 – Use kubectl describe for Troubleshooting

**Context:** A Deployment `troubleshoot-app` with 3 replicas and a Service `troubleshoot-svc` exist in namespace `q52`. The Service has no endpoints and cannot reach the pods.

## Your Task

1. Use `kubectl describe service troubleshoot-svc -n q52` to examine the Service configuration.
2. Use `kubectl describe deployment troubleshoot-app -n q52` to check the pod labels.
3. Identify the mismatch between the Service selector and the Deployment pod labels.
4. Fix the Service selector to match the Deployment pods (selector should be `app: troubleshoot-app`).
5. Verify the Service now has endpoints.

## Docs

- https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/
