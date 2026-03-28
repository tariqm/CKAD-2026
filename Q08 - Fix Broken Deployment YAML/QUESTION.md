# Question 8 – Fix Broken Deployment YAML

File `/root/broken-deploy.yaml` contains a Deployment manifest that fails to apply.

The file has the following issues:

1. Uses deprecated API version
2. Missing required `selector` field
3. Selector doesn't match template labels

## Your Task

1. Fix the YAML file to use `apiVersion: apps/v1`
2. Add a proper `selector` field that matches the template labels
3. Apply the fixed manifest and ensure the Deployment is running

## Docs

- [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
