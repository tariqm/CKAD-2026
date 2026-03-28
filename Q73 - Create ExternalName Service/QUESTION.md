# Question 73 – Create ExternalName Service

**Context:**
An ExternalName service maps a service to an external DNS name. It returns a CNAME record, allowing pods to access external services using an in-cluster service name.

## Your Task

1. Create a service named `external-db` of type `ExternalName` in namespace `q73` that:
   - Points to the external DNS name `db.example.com`

## Docs

- [ExternalName Services](https://kubernetes.io/docs/concepts/services-networking/service/#externalname)
