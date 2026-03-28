# Answer 65 – Create ServiceAccount Token

## Steps

### 1. Create the ServiceAccount

```bash
kubectl create serviceaccount api-service-account -n q65
```

### 2. Generate a token and save it

```bash
kubectl create token api-service-account -n q65 > /tmp/sa-token.txt
```

## Verify

```bash
# Check the ServiceAccount exists
kubectl get serviceaccount api-service-account -n q65

# Confirm the token file exists and is not empty
cat /tmp/sa-token.txt

# Verify the token is valid JWT
kubectl get --raw /api --header "Authorization: Bearer $(cat /tmp/sa-token.txt)" 2>/dev/null && echo "Token is valid"
```
