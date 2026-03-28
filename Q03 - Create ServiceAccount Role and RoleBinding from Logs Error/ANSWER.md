# Answer 3 – Create ServiceAccount, Role, and RoleBinding from Logs Error

## Step 1 – Create ServiceAccount

```bash
kubectl create sa log-sa -n audit
```

## Step 2 – Create Role

```bash
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: log-role
  namespace: audit
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["get", "list", "watch"]
EOF
```

## Step 3 – Create RoleBinding

```bash
kubectl create rolebinding log-rb \
  --role=log-role \
  --serviceaccount=audit:log-sa \
  -n audit
```

## Step 4 – Update Pod to use ServiceAccount

Pods have immutable `serviceAccountName`, so delete and recreate:

```bash
kubectl get pod log-collector -n audit -o yaml > /tmp/log-collector.yaml
```

Edit the file to set `spec.serviceAccountName: log-sa` and remove `spec.serviceAccount` if present.

```bash
kubectl delete pod log-collector -n audit
kubectl apply -f /tmp/log-collector.yaml
```
