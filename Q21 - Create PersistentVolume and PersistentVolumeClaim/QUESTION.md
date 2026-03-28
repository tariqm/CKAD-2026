# Question 21 – Create PersistentVolume and PersistentVolumeClaim

**Context:** PersistentVolumes (PVs) provide storage in a cluster. PersistentVolumeClaims (PVCs) are requests for storage by a user. PVs are cluster-scoped resources, while PVCs are namespaced.

## Your Task

1. Create a PersistentVolume named `task-pv` with:
   - Capacity: `1Gi`
   - Access mode: `ReadWriteOnce`
   - hostPath: `/mnt/data`
   - storageClassName: `manual`

2. In namespace `q21`, create a PersistentVolumeClaim named `task-pvc` with:
   - Request: `500Mi`
   - Access mode: `ReadWriteOnce`
   - storageClassName: `manual`

3. The PVC should automatically bind to the PV.

## Docs

- [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
