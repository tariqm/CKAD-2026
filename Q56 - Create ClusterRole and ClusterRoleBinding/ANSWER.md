# Answer 56 – Create ClusterRole and ClusterRoleBinding

## Steps

1. Create the ClusterRole:

```bash
kubectl create clusterrole node-viewer \
  --verb=get,list,watch \
  --resource=nodes
```

2. Create the ClusterRoleBinding:

```bash
kubectl create clusterrolebinding cluster-viewer-binding \
  --clusterrole=node-viewer \
  --serviceaccount=q56:cluster-viewer
```

## Verify

```bash
# Check ClusterRole
kubectl describe clusterrole node-viewer

# Check ClusterRoleBinding
kubectl describe clusterrolebinding cluster-viewer-binding

# Verify the binding references the correct SA
kubectl get clusterrolebinding cluster-viewer-binding -o yaml
```
