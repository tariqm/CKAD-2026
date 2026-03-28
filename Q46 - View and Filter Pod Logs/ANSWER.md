# Answer 46 – View and Filter Pod Logs

## Steps

### Step 1: Capture logs from error-pod to file

```bash
kubectl logs error-pod -n q46 > /root/q46-errors.txt
```

## Verify

```bash
cat /root/q46-errors.txt
grep "ERROR" /root/q46-errors.txt
```

Expected: the file exists and contains lines with "ERROR: something failed".
