# Question 74 – NetworkPolicy Allow Specific Port

**Context:**
NetworkPolicies can restrict traffic to pods based on specific ports, providing fine-grained control over which ports are accessible.

## Your Task

1. A deployment named `web-deploy` already exists in namespace `q74` with pods labeled `app=web`.
2. Create a NetworkPolicy named `allow-port-80` in namespace `q74` that:
   - Applies to pods with label `app=web`
   - Allows ingress traffic only on port `80` (TCP)
   - Includes `Ingress` in its policy types

## Docs

- [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
