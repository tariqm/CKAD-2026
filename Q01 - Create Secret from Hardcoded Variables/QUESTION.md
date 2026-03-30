# Question 1 – Create Secret from Hardcoded Variables

In namespace `q01`, Deployment `api-server` exists with hard-coded environment variables:

- `DB_USER=admin`
- `DB_PASS=Secret123!`

## Your Task

1. Create a Secret named `db-credentials` in namespace `q01` containing these credentials
2. Update Deployment `api-server` to use the Secret via `valueFrom.secretKeyRef`
3. Do not change the Deployment name or namespace

## Docs

- [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
