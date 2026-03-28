# Answer 66 – Fix RBAC Permission Error

## Step-by-step Solution

### Step 1: Inspect the current Role

```bash
kubectl get role deploy-role -n q66 -o yaml
```

You will see it only has rules for pods with get and list verbs.

### Step 2: Update the Role to include deployments

```bash
kubectl apply -f - <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: deploy-role
  namespace: q66
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list"]
- apiGroups: ["apps"]
  resources: ["deployments"]
  verbs: ["get", "list", "create", "update"]
EOF
```

### Step 3: Verify the Role was updated

```bash
kubectl get role deploy-role -n q66 -o yaml
```

## Verify

```bash
# Check the Role includes deployments
kubectl get role deploy-role -n q66 -o jsonpath='{.rules}' | python3 -m json.tool

# Test permissions using auth can-i
kubectl auth can-i create deployments --as=system:serviceaccount:q66:deploy-sa -n q66
```
