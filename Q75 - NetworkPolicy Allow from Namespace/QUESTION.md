# Question 75 – NetworkPolicy Allow from Namespace

**Context:**
NetworkPolicies can restrict ingress traffic based on the source namespace, allowing only pods from specific namespaces to communicate with the target pods.

## Your Task

1. A deployment named `backend-deploy` already exists in namespace `q75` with pods labeled `app=backend`.
2. A namespace `q75-frontend` exists with the label `purpose=frontend`.
3. Create a NetworkPolicy named `allow-from-frontend` in namespace `q75` that:
   - Applies to pods with label `app=backend`
   - Allows ingress traffic only from pods in namespaces labeled `purpose=frontend`
   - Includes `Ingress` in its policy types

## Docs

- [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
