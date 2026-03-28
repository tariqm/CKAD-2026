# Answer 55 – Create ServiceAccount and Bind to Role

## Steps

1. Create the ServiceAccount:

```bash
kubectl create serviceaccount app-sa -n q55
```

2. Create the Role:

```bash
kubectl create role pod-reader -n q55 \
  --verb=get,list,watch \
  --resource=pods
```

3. Create the RoleBinding:

```bash
kubectl create rolebinding app-sa-binding -n q55 \
  --role=pod-reader \
  --serviceaccount=q55:app-sa
```

## Verify

```bash
# Check ServiceAccount
kubectl get serviceaccount app-sa -n q55

# Check Role
kubectl describe role pod-reader -n q55

# Check RoleBinding
kubectl describe rolebinding app-sa-binding -n q55
```
