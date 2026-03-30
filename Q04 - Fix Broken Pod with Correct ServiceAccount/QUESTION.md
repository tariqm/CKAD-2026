# Question 4 – Fix Broken Pod with Correct ServiceAccount

In namespace `q04`, Pod `metrics-pod` is using ServiceAccount `wrong-sa` and receiving authorization errors.

Multiple ServiceAccounts, Roles, and RoleBindings already exist in the namespace:

- **ServiceAccounts:** `monitor-sa`, `wrong-sa`, `admin-sa`
- **Roles:** `metrics-reader`, `full-access`, `view-only`
- **RoleBindings:** `monitor-binding`, `admin-binding`

## Your Task

1. Identify which ServiceAccount/Role/RoleBinding combination has the correct permissions
2. Update Pod `metrics-pod` to use the correct ServiceAccount
3. Verify the Pod stops showing authorization errors

**Hint:** Check existing RoleBindings to see which ServiceAccount is bound to which Role.

## Docs

- [ServiceAccounts](https://kubernetes.io/docs/concepts/security/service-accounts/)
