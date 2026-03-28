# Answer 62 – Use Projected Volume with Secret and ConfigMap

## Steps

### 1. Create the Pod with a projected volume

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: projected-pod
  namespace: q62
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    volumeMounts:
    - name: combined-vol
      mountPath: /etc/app-config
  volumes:
  - name: combined-vol
    projected:
      sources:
      - secret:
          name: app-secret
      - configMap:
          name: app-config
EOF
```

## Verify

```bash
# Check the pod is running
kubectl get pod projected-pod -n q62

# Verify the secret and configmap files are mounted
kubectl exec projected-pod -n q62 -- ls /etc/app-config

# Read the config file
kubectl exec projected-pod -n q62 -- cat /etc/app-config/app.properties

# Read the secret file
kubectl exec projected-pod -n q62 -- cat /etc/app-config/db-password
```
