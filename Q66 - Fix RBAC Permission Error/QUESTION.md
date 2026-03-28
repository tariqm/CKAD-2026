# Question 66 – Fix RBAC Permission Error

**Context:**
A ServiceAccount `deploy-sa` in namespace `q66` is used by pod `deploy-tool` to manage deployments. However, the Role `deploy-role` only grants permissions for pods, not deployments. The pod cannot create or manage deployments.

## Your Task

1. Inspect the existing Role `deploy-role` in namespace `q66`.
2. Update the Role `deploy-role` to also allow `get`, `list`, `create`, and `update` on the `deployments` resource in the `apps` API group.
3. Ensure the existing pod and RoleBinding permissions remain intact.

## Docs

- [RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
