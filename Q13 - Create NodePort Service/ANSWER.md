# Answer 13 – Create NodePort Service

```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: api-nodeport
  namespace: default
spec:
  type: NodePort
  selector:
    app: api
  ports:
    - port: 80
      targetPort: 9090
      protocol: TCP
EOF
```

## Verify

```bash
kubectl get svc api-nodeport -n default
kubectl describe svc api-nodeport -n default
```
