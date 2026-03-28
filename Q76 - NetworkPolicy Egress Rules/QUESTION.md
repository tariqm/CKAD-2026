# Question 76 – NetworkPolicy Egress Rules

**Context:**
NetworkPolicies can also control outbound (egress) traffic from pods. This is useful for restricting which external services a pod can communicate with, while still allowing essential traffic like DNS.

## Your Task

1. A deployment named `app-deploy` already exists in namespace `q76` with pods labeled `app=secure-app`.
2. Create a NetworkPolicy named `restrict-egress` in namespace `q76` that:
   - Applies to pods with label `app=secure-app`
   - Includes `Egress` in its policy types
   - Allows egress to DNS on port 53 (both TCP and UDP)
   - Allows egress to port 443 (TCP)
   - Denies all other egress traffic

## Docs

- [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
