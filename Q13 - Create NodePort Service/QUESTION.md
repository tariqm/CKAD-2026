# Question 13 – Create NodePort Service

In namespace `q13`, Deployment `api-server` exists with Pods labeled `app=api` and container port `9090`.

## Your Task

Create a Service named `api-nodeport` that:

- Type: `NodePort`
- Selects Pods with label `app=api`
- Exposes Service port `80` mapping to target port `9090`

## Docs

- [NodePort Services](https://kubernetes.io/docs/concepts/services-networking/service/#nodeport)
