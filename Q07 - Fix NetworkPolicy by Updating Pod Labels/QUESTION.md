# Question 7 – Fix NetworkPolicy by Updating Pod Labels

In namespace `q07`, three Pods exist:

- `frontend` with label `role=wrong-frontend`
- `backend` with label `role=wrong-backend`
- `database` with label `role=wrong-db`

Three NetworkPolicies exist:

- `deny-all` (default deny)
- `allow-frontend-to-backend` (allows traffic from `role=frontend` to `role=backend`)
- `allow-backend-to-db` (allows traffic from `role=backend` to `role=db`)

## Your Task

Update the Pod labels (do **NOT** modify NetworkPolicies) to enable the communication chain:
`frontend` → `backend` → `database`

**Time Saver Tip:** Use `kubectl label` instead of editing YAML and recreating Pods.

## Docs

- [NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policy/)
