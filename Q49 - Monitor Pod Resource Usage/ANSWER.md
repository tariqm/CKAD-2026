# Answer 49 – Monitor Pod Resource Usage

## Step 1: Try kubectl top

```bash
kubectl top pods -n q49 > /root/q49-top.txt 2>&1
```

## Step 2: If metrics-server is not available, use fallback

```bash
if ! kubectl top pods -n q49 > /root/q49-top.txt 2>&1; then
  kubectl get pods -n q49 -o wide > /root/q49-top.txt
fi
```

## Verify

```bash
cat /root/q49-top.txt
```

The file should contain either resource usage metrics or pod details.
