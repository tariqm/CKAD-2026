# Question 55 – Create ServiceAccount and Bind to Role

**Context:** You need to set up RBAC for an application running in namespace `q55`. The application needs read-only access to Pods in its namespace.

## Your Task

1. Create a ServiceAccount named `app-sa` in namespace `q55`.
2. Create a Role named `pod-reader` in namespace `q55` that allows `get`, `list`, and `watch` on `pods`.
3. Create a RoleBinding named `app-sa-binding` in namespace `q55` that binds the Role `pod-reader` to the ServiceAccount `app-sa`.

## Docs

- [RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [Using RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#role-and-clusterrole)
