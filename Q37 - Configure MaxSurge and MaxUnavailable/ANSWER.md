# Answer 37 – Configure MaxSurge and MaxUnavailable

## Steps

### Step 1: Update the Deployment strategy and image

```bash
kubectl patch deployment strategy-app -n q37 --type=strategic -p '{
  "spec": {
    "strategy": {
      "type": "RollingUpdate",
      "rollingUpdate": {
        "maxSurge": 1,
        "maxUnavailable": 0
      }
    },
    "template": {
      "spec": {
        "containers": [
          {
            "name": "nginx",
            "image": "nginx:1.25"
          }
        ]
      }
    }
  }
}'
```

Alternatively, you can use `kubectl edit`:

```bash
kubectl edit deployment strategy-app -n q37
```

And modify the strategy section and image, or do it in two steps:

```bash
kubectl patch deployment strategy-app -n q37 -p '{"spec":{"strategy":{"type":"RollingUpdate","rollingUpdate":{"maxSurge":1,"maxUnavailable":0}}}}'
kubectl set image deployment/strategy-app nginx=nginx:1.25 -n q37
```

### Step 2: Wait for rollout to complete

```bash
kubectl rollout status deployment/strategy-app -n q37
```

## Verify

```bash
kubectl get deployment strategy-app -n q37 -o jsonpath='{.spec.strategy}' | jq .
kubectl get deployment strategy-app -n q37 -o jsonpath='{.spec.template.spec.containers[0].image}'
```

Expected: strategy type `RollingUpdate`, maxSurge `1`, maxUnavailable `0`, image `nginx:1.25`.
