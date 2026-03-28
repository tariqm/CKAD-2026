# Question 56 – Create ClusterRole and ClusterRoleBinding

**Context:** A ServiceAccount named `cluster-viewer` has been created in namespace `q56`. You need to grant it cluster-wide read access to nodes.

## Your Task

1. Create a ClusterRole named `node-viewer` that allows `get`, `list`, and `watch` on `nodes`.
2. Create a ClusterRoleBinding named `cluster-viewer-binding` that binds the ClusterRole `node-viewer` to the ServiceAccount `cluster-viewer` in namespace `q56`.

## Docs

- [RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [ClusterRole and ClusterRoleBinding](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#clusterrole-example)
