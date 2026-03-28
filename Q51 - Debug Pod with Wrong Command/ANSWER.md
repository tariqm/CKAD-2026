# Answer 51 – Debug Pod with Wrong Command

## Step 1: Diagnose the issue

```bash
kubectl get pods -n q51
kubectl describe pod wrong-cmd-pod -n q51
kubectl logs wrong-cmd-pod -n q51
```

The logs or events will show that `nginx-wrong` binary is not found.

## Step 2: Delete the broken pod

```bash
kubectl delete pod wrong-cmd-pod -n q51
```

## Step 3: Recreate with correct command

```bash
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: wrong-cmd-pod
  namespace: q51
spec:
  containers:
  - name: nginx
    image: nginx:latest
    command: ["nginx", "-g", "daemon off;"]
EOF
```

## Verify

```bash
kubectl get pods -n q51
kubectl logs wrong-cmd-pod -n q51
```
