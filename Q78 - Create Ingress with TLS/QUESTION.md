# Question 78 – Create Ingress with TLS

**Context:** You are working in namespace `q78`. A Deployment `secure-web` and Service `secure-web-svc` are already running. A TLS secret `tls-secret` has been created with a self-signed certificate for `secure.example.com`.

## Your Task

1. Create an Ingress named `secure-ingress` in namespace `q78`.
2. Configure TLS using the existing secret `tls-secret` for host `secure.example.com`.
3. Add a routing rule for host `secure.example.com` with path `/` (pathType `Prefix`) that routes to service `secure-web-svc` on port `443`.

## Docs

- [Ingress TLS](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls)
- [Ingress Resource](https://kubernetes.io/docs/concepts/services-networking/ingress/)
