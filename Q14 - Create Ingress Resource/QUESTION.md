# Question 14 – Create Ingress Resource

In namespace `default`, the following resources exist:

- Deployment `web-deploy` with Pods labeled `app=web`
- Service `web-svc` with selector `app=web` on port `8080`

## Your Task

Create an Ingress named `web-ingress` that:

- Routes host `web.example.com`
- Path `/` with `pathType: Prefix`
- Backend Service `web-svc` on port `8080`
- Uses API version `networking.k8s.io/v1`

## Docs

- [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
