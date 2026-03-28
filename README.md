# CKAD 2026 - Practice Questions

A hands-on lab with **78 practice questions** for the [Certified Kubernetes Application Developer (CKAD)](https://www.cncf.io/certification/ckad/) exam. Each question includes automated environment setup, a scoring checker, and a full reference solution.

## Prerequisites

- A running Kubernetes cluster (e.g. [minikube](https://minikube.sigs.k8s.io/), [kind](https://kind.sigs.k8s.io/), or a cloud provider)
- `kubectl` configured and pointing to your cluster
- `bash` shell

## How It Works

Each question lives in its own folder with four files:

| File | Purpose |
|------|---------|
| `QUESTION.md` | Read this first -- the task description and requirements |
| `setup.sh` | Run this to set up the Kubernetes resources for the exercise |
| `check.sh` | Run this after you attempt the question to validate and score your solution |
| `ANSWER.md` | The reference solution (no peeking!) |

### Quick Start

```bash
# 1. Pick a question and set up the environment
bash "Q01 - Create Secret from Hardcoded Variables/setup.sh"

# 2. Read the question
cat "Q01 - Create Secret from Hardcoded Variables/QUESTION.md"

# 3. Solve it using kubectl...

# 4. Check your answer
bash "Q01 - Create Secret from Hardcoded Variables/check.sh"
```

## Topics Covered

| Domain | Questions |
|--------|-----------|
| **Application Design & Build** | Pods, Deployments, Multi-container patterns, Init containers, Jobs, CronJobs, Volumes |
| **Application Deployment** | Rolling updates, Rollbacks, Blue-green, Canary, Deployment strategies |
| **Application Observability & Maintenance** | Probes (liveness, readiness, startup), Logging, Debugging, Resource monitoring |
| **Application Environment, Configuration & Security** | Secrets, ConfigMaps, SecurityContext, RBAC, ServiceAccounts, NetworkPolicies, ResourceQuotas |
| **Services & Networking** | ClusterIP, NodePort, Headless, ExternalName, Ingress, NetworkPolicies |

## Questions

| # | Topic | Question | Answer |
|---|-------|----------|--------|
| 01 | Create Secret from Hardcoded Variables | [Question](Q01%20-%20Create%20Secret%20from%20Hardcoded%20Variables/QUESTION.md) | [Answer](Q01%20-%20Create%20Secret%20from%20Hardcoded%20Variables/ANSWER.md) |
| 02 | Create CronJob with Schedule and History Limits | [Question](Q02%20-%20Create%20CronJob%20with%20Schedule%20and%20History%20Limits/QUESTION.md) | [Answer](Q02%20-%20Create%20CronJob%20with%20Schedule%20and%20History%20Limits/ANSWER.md) |
| 03 | Create ServiceAccount Role and RoleBinding from Logs Error | [Question](Q03%20-%20Create%20ServiceAccount%20Role%20and%20RoleBinding%20from%20Logs%20Error/QUESTION.md) | [Answer](Q03%20-%20Create%20ServiceAccount%20Role%20and%20RoleBinding%20from%20Logs%20Error/ANSWER.md) |
| 04 | Fix Broken Pod with Correct ServiceAccount | [Question](Q04%20-%20Fix%20Broken%20Pod%20with%20Correct%20ServiceAccount/QUESTION.md) | [Answer](Q04%20-%20Fix%20Broken%20Pod%20with%20Correct%20ServiceAccount/ANSWER.md) |
| 05 | Build Container Image with Podman and Save as Tarball | [Question](Q05%20-%20Build%20Container%20Image%20with%20Podman%20and%20Save%20as%20Tarball/QUESTION.md) | [Answer](Q05%20-%20Build%20Container%20Image%20with%20Podman%20and%20Save%20as%20Tarball/ANSWER.md) |
| 06 | Create Canary Deployment with Manual Traffic Split | [Question](Q06%20-%20Create%20Canary%20Deployment%20with%20Manual%20Traffic%20Split/QUESTION.md) | [Answer](Q06%20-%20Create%20Canary%20Deployment%20with%20Manual%20Traffic%20Split/ANSWER.md) |
| 07 | Fix NetworkPolicy by Updating Pod Labels | [Question](Q07%20-%20Fix%20NetworkPolicy%20by%20Updating%20Pod%20Labels/QUESTION.md) | [Answer](Q07%20-%20Fix%20NetworkPolicy%20by%20Updating%20Pod%20Labels/ANSWER.md) |
| 08 | Fix Broken Deployment YAML | [Question](Q08%20-%20Fix%20Broken%20Deployment%20YAML/QUESTION.md) | [Answer](Q08%20-%20Fix%20Broken%20Deployment%20YAML/ANSWER.md) |
| 09 | Perform Rolling Update and Rollback | [Question](Q09%20-%20Perform%20Rolling%20Update%20and%20Rollback/QUESTION.md) | [Answer](Q09%20-%20Perform%20Rolling%20Update%20and%20Rollback/ANSWER.md) |
| 10 | Add Readiness Probe to Deployment | [Question](Q10%20-%20Add%20Readiness%20Probe%20to%20Deployment/QUESTION.md) | [Answer](Q10%20-%20Add%20Readiness%20Probe%20to%20Deployment/ANSWER.md) |
| 11 | Configure Pod and Container Security Context | [Question](Q11%20-%20Configure%20Pod%20and%20Container%20Security%20Context/QUESTION.md) | [Answer](Q11%20-%20Configure%20Pod%20and%20Container%20Security%20Context/ANSWER.md) |
| 12 | Fix Service Selector | [Question](Q12%20-%20Fix%20Service%20Selector/QUESTION.md) | [Answer](Q12%20-%20Fix%20Service%20Selector/ANSWER.md) |
| 13 | Create NodePort Service | [Question](Q13%20-%20Create%20NodePort%20Service/QUESTION.md) | [Answer](Q13%20-%20Create%20NodePort%20Service/ANSWER.md) |
| 14 | Create Ingress Resource | [Question](Q14%20-%20Create%20Ingress%20Resource/QUESTION.md) | [Answer](Q14%20-%20Create%20Ingress%20Resource/ANSWER.md) |
| 15 | Fix Ingress PathType | [Question](Q15%20-%20Fix%20Ingress%20PathType/QUESTION.md) | [Answer](Q15%20-%20Fix%20Ingress%20PathType/ANSWER.md) |
| 16 | Add Resource Requests and Limits to Pod | [Question](Q16%20-%20Add%20Resource%20Requests%20and%20Limits%20to%20Pod/QUESTION.md) | [Answer](Q16%20-%20Add%20Resource%20Requests%20and%20Limits%20to%20Pod/ANSWER.md) |
| 17 | Create Multi-Container Pod with Sidecar | [Question](Q17%20-%20Create%20Multi-Container%20Pod%20with%20Sidecar/QUESTION.md) | [Answer](Q17%20-%20Create%20Multi-Container%20Pod%20with%20Sidecar/ANSWER.md) |
| 18 | Create Pod with Init Container | [Question](Q18%20-%20Create%20Pod%20with%20Init%20Container/QUESTION.md) | [Answer](Q18%20-%20Create%20Pod%20with%20Init%20Container/ANSWER.md) |
| 19 | Create Job with Completions and Parallelism | [Question](Q19%20-%20Create%20Job%20with%20Completions%20and%20Parallelism/QUESTION.md) | [Answer](Q19%20-%20Create%20Job%20with%20Completions%20and%20Parallelism/ANSWER.md) |
| 20 | Create Pod with EmptyDir Shared Volume | [Question](Q20%20-%20Create%20Pod%20with%20EmptyDir%20Shared%20Volume/QUESTION.md) | [Answer](Q20%20-%20Create%20Pod%20with%20EmptyDir%20Shared%20Volume/ANSWER.md) |
| 21 | Create PersistentVolume and PersistentVolumeClaim | [Question](Q21%20-%20Create%20PersistentVolume%20and%20PersistentVolumeClaim/QUESTION.md) | [Answer](Q21%20-%20Create%20PersistentVolume%20and%20PersistentVolumeClaim/ANSWER.md) |
| 22 | Mount PVC in a Pod | [Question](Q22%20-%20Mount%20PVC%20in%20a%20Pod/QUESTION.md) | [Answer](Q22%20-%20Mount%20PVC%20in%20a%20Pod/ANSWER.md) |
| 23 | Create Deployment with Custom Labels and Annotations | [Question](Q23%20-%20Create%20Deployment%20with%20Custom%20Labels%20and%20Annotations/QUESTION.md) | [Answer](Q23%20-%20Create%20Deployment%20with%20Custom%20Labels%20and%20Annotations/ANSWER.md) |
| 24 | Create Pod with Command and Args Override | [Question](Q24%20-%20Create%20Pod%20with%20Command%20and%20Args%20Override/QUESTION.md) | [Answer](Q24%20-%20Create%20Pod%20with%20Command%20and%20Args%20Override/ANSWER.md) |
| 25 | Build Multi-Container Pod with Log Aggregator | [Question](Q25%20-%20Build%20Multi-Container%20Pod%20with%20Log%20Aggregator/QUESTION.md) | [Answer](Q25%20-%20Build%20Multi-Container%20Pod%20with%20Log%20Aggregator/ANSWER.md) |
| 26 | Create Job with BackoffLimit | [Question](Q26%20-%20Create%20Job%20with%20BackoffLimit/QUESTION.md) | [Answer](Q26%20-%20Create%20Job%20with%20BackoffLimit/ANSWER.md) |
| 27 | Create CronJob with Concurrency Policy | [Question](Q27%20-%20Create%20CronJob%20with%20Concurrency%20Policy/QUESTION.md) | [Answer](Q27%20-%20Create%20CronJob%20with%20Concurrency%20Policy/ANSWER.md) |
| 28 | Fix CrashLoopBackOff Pod | [Question](Q28%20-%20Fix%20CrashLoopBackOff%20Pod/QUESTION.md) | [Answer](Q28%20-%20Fix%20CrashLoopBackOff%20Pod/ANSWER.md) |
| 29 | Create Pod with HostPath Volume | [Question](Q29%20-%20Create%20Pod%20with%20HostPath%20Volume/QUESTION.md) | [Answer](Q29%20-%20Create%20Pod%20with%20HostPath%20Volume/ANSWER.md) |
| 30 | Create Deployment with Multiple Containers | [Question](Q30%20-%20Create%20Deployment%20with%20Multiple%20Containers/QUESTION.md) | [Answer](Q30%20-%20Create%20Deployment%20with%20Multiple%20Containers/ANSWER.md) |
| 31 | Create Deployment from Scratch with Port | [Question](Q31%20-%20Create%20Deployment%20from%20Scratch%20with%20Port/QUESTION.md) | [Answer](Q31%20-%20Create%20Deployment%20from%20Scratch%20with%20Port/ANSWER.md) |
| 32 | Create Temporary Debug Pod | [Question](Q32%20-%20Create%20Temporary%20Debug%20Pod/QUESTION.md) | [Answer](Q32%20-%20Create%20Temporary%20Debug%20Pod/ANSWER.md) |
| 33 | Create Pod with Resource Requests Only | [Question](Q33%20-%20Create%20Pod%20with%20Resource%20Requests%20Only/QUESTION.md) | [Answer](Q33%20-%20Create%20Pod%20with%20Resource%20Requests%20Only/ANSWER.md) |
| 34 | Scale Deployment | [Question](Q34%20-%20Scale%20Deployment/QUESTION.md) | [Answer](Q34%20-%20Scale%20Deployment/ANSWER.md) |
| 35 | Create Deployment with Rolling Update Strategy | [Question](Q35%20-%20Create%20Deployment%20with%20Rolling%20Update%20Strategy/QUESTION.md) | [Answer](Q35%20-%20Create%20Deployment%20with%20Rolling%20Update%20Strategy/ANSWER.md) |
| 36 | Blue-Green Deployment Switch | [Question](Q36%20-%20Blue-Green%20Deployment%20Switch/QUESTION.md) | [Answer](Q36%20-%20Blue-Green%20Deployment%20Switch/ANSWER.md) |
| 37 | Configure MaxSurge and MaxUnavailable | [Question](Q37%20-%20Configure%20MaxSurge%20and%20MaxUnavailable/QUESTION.md) | [Answer](Q37%20-%20Configure%20MaxSurge%20and%20MaxUnavailable/ANSWER.md) |
| 38 | Create Deployment with Change Cause Annotation | [Question](Q38%20-%20Create%20Deployment%20with%20Change%20Cause%20Annotation/QUESTION.md) | [Answer](Q38%20-%20Create%20Deployment%20with%20Change%20Cause%20Annotation/ANSWER.md) |
| 39 | Implement Recreate Deployment Strategy | [Question](Q39%20-%20Implement%20Recreate%20Deployment%20Strategy/QUESTION.md) | [Answer](Q39%20-%20Implement%20Recreate%20Deployment%20Strategy/ANSWER.md) |
| 40 | Rolling Restart Deployment | [Question](Q40%20-%20Rolling%20Restart%20Deployment/QUESTION.md) | [Answer](Q40%20-%20Rolling%20Restart%20Deployment/ANSWER.md) |
| 41 | Create Deployment with Env Vars from ConfigMap | [Question](Q41%20-%20Create%20Deployment%20with%20Env%20Vars%20from%20ConfigMap/QUESTION.md) | [Answer](Q41%20-%20Create%20Deployment%20with%20Env%20Vars%20from%20ConfigMap/ANSWER.md) |
| 42 | Fix Failed Deployment Rollout | [Question](Q42%20-%20Fix%20Failed%20Deployment%20Rollout/QUESTION.md) | [Answer](Q42%20-%20Fix%20Failed%20Deployment%20Rollout/ANSWER.md) |
| 43 | Add Liveness Probe with Exec Command | [Question](Q43%20-%20Add%20Liveness%20Probe%20with%20Exec%20Command/QUESTION.md) | [Answer](Q43%20-%20Add%20Liveness%20Probe%20with%20Exec%20Command/ANSWER.md) |
| 44 | Add Startup Probe to Slow Starting Pod | [Question](Q44%20-%20Add%20Startup%20Probe%20to%20Slow%20Starting%20Pod/QUESTION.md) | [Answer](Q44%20-%20Add%20Startup%20Probe%20to%20Slow%20Starting%20Pod/ANSWER.md) |
| 45 | Debug CrashLoopBackOff Pod | [Question](Q45%20-%20Debug%20CrashLoopBackOff%20Pod/QUESTION.md) | [Answer](Q45%20-%20Debug%20CrashLoopBackOff%20Pod/ANSWER.md) |
| 46 | View and Filter Pod Logs | [Question](Q46%20-%20View%20and%20Filter%20Pod%20Logs/QUESTION.md) | [Answer](Q46%20-%20View%20and%20Filter%20Pod%20Logs/ANSWER.md) |
| 47 | Debug Pending Pod Due to Resource Constraints | [Question](Q47%20-%20Debug%20Pending%20Pod%20Due%20to%20Resource%20Constraints/QUESTION.md) | [Answer](Q47%20-%20Debug%20Pending%20Pod%20Due%20to%20Resource%20Constraints/ANSWER.md) |
| 48 | Debug ImagePullBackOff Pod | [Question](Q48%20-%20Debug%20ImagePullBackOff%20Pod/QUESTION.md) | [Answer](Q48%20-%20Debug%20ImagePullBackOff%20Pod/ANSWER.md) |
| 49 | Monitor Pod Resource Usage | [Question](Q49%20-%20Monitor%20Pod%20Resource%20Usage/QUESTION.md) | [Answer](Q49%20-%20Monitor%20Pod%20Resource%20Usage/ANSWER.md) |
| 50 | Create Pod with All Three Probes | [Question](Q50%20-%20Create%20Pod%20with%20All%20Three%20Probes/QUESTION.md) | [Answer](Q50%20-%20Create%20Pod%20with%20All%20Three%20Probes/ANSWER.md) |
| 51 | Debug Pod with Wrong Command | [Question](Q51%20-%20Debug%20Pod%20with%20Wrong%20Command/QUESTION.md) | [Answer](Q51%20-%20Debug%20Pod%20with%20Wrong%20Command/ANSWER.md) |
| 52 | Use kubectl describe for Troubleshooting | [Question](Q52%20-%20Use%20kubectl%20describe%20for%20Troubleshooting/QUESTION.md) | [Answer](Q52%20-%20Use%20kubectl%20describe%20for%20Troubleshooting/ANSWER.md) |
| 53 | Create Logging Sidecar Container | [Question](Q53%20-%20Create%20Logging%20Sidecar%20Container/QUESTION.md) | [Answer](Q53%20-%20Create%20Logging%20Sidecar%20Container/ANSWER.md) |
| 54 | Mount Secret as Volume in Pod | [Question](Q54%20-%20Mount%20Secret%20as%20Volume%20in%20Pod/QUESTION.md) | [Answer](Q54%20-%20Mount%20Secret%20as%20Volume%20in%20Pod/ANSWER.md) |
| 55 | Create ServiceAccount and Bind to Role | [Question](Q55%20-%20Create%20ServiceAccount%20and%20Bind%20to%20Role/QUESTION.md) | [Answer](Q55%20-%20Create%20ServiceAccount%20and%20Bind%20to%20Role/ANSWER.md) |
| 56 | Create ClusterRole and ClusterRoleBinding | [Question](Q56%20-%20Create%20ClusterRole%20and%20ClusterRoleBinding/QUESTION.md) | [Answer](Q56%20-%20Create%20ClusterRole%20and%20ClusterRoleBinding/ANSWER.md) |
| 57 | Set SecurityContext RunAsNonRoot | [Question](Q57%20-%20Set%20SecurityContext%20RunAsNonRoot/QUESTION.md) | [Answer](Q57%20-%20Set%20SecurityContext%20RunAsNonRoot/ANSWER.md) |
| 58 | Set SecurityContext ReadOnlyRootFilesystem | [Question](Q58%20-%20Set%20SecurityContext%20ReadOnlyRootFilesystem/QUESTION.md) | [Answer](Q58%20-%20Set%20SecurityContext%20ReadOnlyRootFilesystem/ANSWER.md) |
| 59 | Create Pod with fsGroup SecurityContext | [Question](Q59%20-%20Create%20Pod%20with%20fsGroup%20SecurityContext/QUESTION.md) | [Answer](Q59%20-%20Create%20Pod%20with%20fsGroup%20SecurityContext/ANSWER.md) |
| 60 | Create ResourceQuota in Namespace | [Question](Q60%20-%20Create%20ResourceQuota%20in%20Namespace/QUESTION.md) | [Answer](Q60%20-%20Create%20ResourceQuota%20in%20Namespace/ANSWER.md) |
| 61 | Create LimitRange in Namespace | [Question](Q61%20-%20Create%20LimitRange%20in%20Namespace/QUESTION.md) | [Answer](Q61%20-%20Create%20LimitRange%20in%20Namespace/ANSWER.md) |
| 62 | Use Projected Volume with Secret and ConfigMap | [Question](Q62%20-%20Use%20Projected%20Volume%20with%20Secret%20and%20ConfigMap/QUESTION.md) | [Answer](Q62%20-%20Use%20Projected%20Volume%20with%20Secret%20and%20ConfigMap/ANSWER.md) |
| 63 | Create NetworkPolicy Default Deny All | [Question](Q63%20-%20Create%20NetworkPolicy%20Default%20Deny%20All/QUESTION.md) | [Answer](Q63%20-%20Create%20NetworkPolicy%20Default%20Deny%20All/ANSWER.md) |
| 64 | Drop All Capabilities and Add Specific Ones | [Question](Q64%20-%20Drop%20All%20Capabilities%20and%20Add%20Specific%20Ones/QUESTION.md) | [Answer](Q64%20-%20Drop%20All%20Capabilities%20and%20Add%20Specific%20Ones/ANSWER.md) |
| 65 | Create ServiceAccount Token | [Question](Q65%20-%20Create%20ServiceAccount%20Token/QUESTION.md) | [Answer](Q65%20-%20Create%20ServiceAccount%20Token/ANSWER.md) |
| 66 | Fix RBAC Permission Error | [Question](Q66%20-%20Fix%20RBAC%20Permission%20Error/QUESTION.md) | [Answer](Q66%20-%20Fix%20RBAC%20Permission%20Error/ANSWER.md) |
| 67 | Use Downward API Environment Variables | [Question](Q67%20-%20Use%20Downward%20API%20Environment%20Variables/QUESTION.md) | [Answer](Q67%20-%20Use%20Downward%20API%20Environment%20Variables/ANSWER.md) |
| 68 | Use Downward API Volume | [Question](Q68%20-%20Use%20Downward%20API%20Volume/QUESTION.md) | [Answer](Q68%20-%20Use%20Downward%20API%20Volume/ANSWER.md) |
| 69 | Create Docker Registry Secret | [Question](Q69%20-%20Create%20Docker%20Registry%20Secret/QUESTION.md) | [Answer](Q69%20-%20Create%20Docker%20Registry%20Secret/ANSWER.md) |
| 70 | Create ClusterIP Service | [Question](Q70%20-%20Create%20ClusterIP%20Service/QUESTION.md) | [Answer](Q70%20-%20Create%20ClusterIP%20Service/ANSWER.md) |
| 71 | Expose Deployment via kubectl expose | [Question](Q71%20-%20Expose%20Deployment%20via%20kubectl%20expose/QUESTION.md) | [Answer](Q71%20-%20Expose%20Deployment%20via%20kubectl%20expose/ANSWER.md) |
| 72 | Create Headless Service | [Question](Q72%20-%20Create%20Headless%20Service/QUESTION.md) | [Answer](Q72%20-%20Create%20Headless%20Service/ANSWER.md) |
| 73 | Create ExternalName Service | [Question](Q73%20-%20Create%20ExternalName%20Service/QUESTION.md) | [Answer](Q73%20-%20Create%20ExternalName%20Service/ANSWER.md) |
| 74 | NetworkPolicy Allow Specific Port | [Question](Q74%20-%20NetworkPolicy%20Allow%20Specific%20Port/QUESTION.md) | [Answer](Q74%20-%20NetworkPolicy%20Allow%20Specific%20Port/ANSWER.md) |
| 75 | NetworkPolicy Allow from Namespace | [Question](Q75%20-%20NetworkPolicy%20Allow%20from%20Namespace/QUESTION.md) | [Answer](Q75%20-%20NetworkPolicy%20Allow%20from%20Namespace/ANSWER.md) |
| 76 | NetworkPolicy Egress Rules | [Question](Q76%20-%20NetworkPolicy%20Egress%20Rules/QUESTION.md) | [Answer](Q76%20-%20NetworkPolicy%20Egress%20Rules/ANSWER.md) |
| 77 | Create Ingress with Multiple Paths | [Question](Q77%20-%20Create%20Ingress%20with%20Multiple%20Paths/QUESTION.md) | [Answer](Q77%20-%20Create%20Ingress%20with%20Multiple%20Paths/ANSWER.md) |
| 78 | Create Ingress with TLS | [Question](Q78%20-%20Create%20Ingress%20with%20TLS/QUESTION.md) | [Answer](Q78%20-%20Create%20Ingress%20with%20TLS/ANSWER.md) |

## Tips for the CKAD Exam

- **Practice with `kubectl` imperative commands** -- they save time (e.g. `kubectl run`, `kubectl create`, `kubectl expose`)
- **Bookmark the [Kubernetes docs](https://kubernetes.io/docs/)** -- you can use them during the exam
- **Use `--dry-run=client -o yaml`** to generate YAML templates quickly
- **Know your shortcuts**: `k` for `kubectl`, `-n` for `--namespace`, `-o` for `--output`
- **Time management**: skip hard questions and come back to them

## License

GNU Public 3.0
