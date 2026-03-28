# Question 70 – Create ClusterIP Service

**Context:**
A ClusterIP service provides a stable internal IP address for accessing pods within the cluster. It is the default service type in Kubernetes.

## Your Task

1. A deployment named `web-deploy` already exists in namespace `q70` with pods labeled `app=web` listening on port 80.
2. Create a ClusterIP service named `web-svc` in namespace `q70` that:
   - Selects pods with label `app=web`
   - Exposes port 80
   - Targets port 80 on the pods

## Docs

- [Service](https://kubernetes.io/docs/concepts/services-networking/service/)
