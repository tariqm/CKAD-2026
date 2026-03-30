# Question 3 – Create ServiceAccount, Role, and RoleBinding from Logs Error

In namespace `q03`, Pod `log-collector` exists but is failing with authorization errors.

Check the Pod logs to identify what permissions are needed:

```bash
kubectl logs -n q03 log-collector
```

The logs show: `User "system:serviceaccount:audit:default" cannot list pods in the namespace "q03"`

## Your Task

1. Create a ServiceAccount named `log-sa` in namespace `q03`
2. Create a Role `log-role` that grants `get`, `list`, and `watch` on resource `pods`
3. Create a RoleBinding `log-rb` binding `log-role` to `log-sa`
4. Update Pod `log-collector` to use ServiceAccount `log-sa`

## Docs

- [RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
