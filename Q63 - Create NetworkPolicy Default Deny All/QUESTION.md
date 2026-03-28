# Question 63 – Create NetworkPolicy Default Deny All

**Context:** A Deployment named `web-app` is running in namespace `q63`. You need to create a NetworkPolicy that denies all ingress traffic to all pods in the namespace by default.

## Your Task

1. Create a NetworkPolicy named `deny-all-ingress` in namespace `q63`.
2. The policy must apply to **all** pods in the namespace.
3. The policy must deny **all** ingress traffic (no ingress rules).

## Docs

- [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
- [Default Deny All Ingress](https://kubernetes.io/docs/concepts/services-networking/network-policies/#default-deny-all-ingress-traffic)
