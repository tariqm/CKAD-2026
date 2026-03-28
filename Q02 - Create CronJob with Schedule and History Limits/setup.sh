#!/bin/bash
set -euo pipefail
echo "=== Q2 Setup: Create CronJob with Schedule and History Limits ==="
kubectl create namespace q02 --dry-run=client -o yaml | kubectl apply -f -
echo "No pre-existing resources required for this question."
echo "✅ Q2 setup complete. Create CronJob backup-job from scratch."
