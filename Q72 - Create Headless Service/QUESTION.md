# Question 72 – Create Headless Service

**Context:**
A headless service (with `clusterIP: None`) does not allocate a cluster IP. Instead, DNS returns the individual pod IPs directly. This is commonly used with StatefulSets to provide stable network identities for each pod.

## Your Task

1. A StatefulSet named `db-sts` already exists in namespace `q72` with pods labeled `app=db` listening on port 5432.
2. Create a headless service named `db-headless` in namespace `q72` that:
   - Has `clusterIP: None`
   - Selects pods with label `app=db`
   - Exposes port 5432

## Docs

- [Headless Services](https://kubernetes.io/docs/concepts/services-networking/service/#headless-services)
