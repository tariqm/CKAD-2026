# Question 54 – Mount Secret as Volume in Pod

**Context:** A TLS Secret named `tls-certs` has been created in namespace `q54`. You need to mount this Secret into a Pod so the application can access the certificate files.

## Your Task

1. Create a Pod named `secure-pod` in namespace `q54` using the `nginx:latest` image.
2. Mount the Secret `tls-certs` as a volume at the path `/etc/tls`.
3. The volume mount should be `readOnly: true`.

## Docs

- [Using Secrets](https://kubernetes.io/docs/concepts/configuration/secret/#using-secrets)
- [Using Secrets as files from a Pod](https://kubernetes.io/docs/concepts/configuration/secret/#using-secrets-as-files-from-a-pod)
