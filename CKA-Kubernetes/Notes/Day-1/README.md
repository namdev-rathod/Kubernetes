# Kubernetes - Day 1

Welcome to Day 1 of the Kubernetes learning path — a practical, real-world introduction designed for engineers who want to move from curiosity to production-ready knowledge fast. This note is LinkedIn-ready: concise, technical, and rooted in experience from running real clusters at scale.

## Why Kubernetes matters (elevator pitch)

Kubernetes is the de-facto platform for running containerised applications in production. It provides primitives for deployment, scaling, networking, service discovery, and self-healing so teams can ship features faster while keeping reliability high.

Think of Kubernetes as a distributed OS for cloud-native apps: it schedules work across machines, maintains desired state, and exposes a consistent API for automation.

## What this Day-1 notes covers

- A high-level architecture overview
- Core primitives you must know (pods, deployments, services, volumes)
- The control plane vs. worker nodes
- Practical, real-world operational notes and tips I use in production
- Hands-on commands and a minimal Deployment YAML to try locally

---

## Kubernetes architecture (high level)

Two logical layers:

- Control plane (brain): manages cluster state and API.
- Worker nodes (muscle): run containers and report status.

Control plane components:

- `kube-apiserver` — the single HTTP API endpoint for the cluster (auth, admission, etc.).
- `etcd` — consistent key-value store holding cluster state (only control plane reads/writes).
- `kube-scheduler` — assigns Pods to nodes based on resources and constraints.
- `kube-controller-manager` — runs controllers (deployments, replicasets, node lifecycle, etc.).

Worker node components:

- `kubelet` — agent that ensures containers described in Pods are running.
- `kube-proxy` — implements Service networking (routing, kube-proxy modes depend on kube-proxy or CNI integrations).
- Container runtime (containerd, CRI-O, previously Docker) — runs container images.

Networking and extensions:

- CNI plugins (Calico, Flannel, Weave, Cilium) provide pod networking and policy enforcement.
- Ingress controllers (NGINX, Traefik, Istio/Gateway API) manage L7 traffic and routing.

Diagram (mental):

Control Plane ←→ etcd
	└─ scheduler, controller-manager, apiserver
Nodes: [kubelet + kube-proxy + container runtime] → run Pods

---

## Core primitives (what to master on Day 1)

- Pod: smallest deployable unit (one or more containers that share network and storage).
- Deployment: declarative rollout of Pod replicas + upgrades + rollback.
- ReplicaSet: ensures a specified number of pod replicas are running (usually managed by Deployments).
- Service: stable network endpoint for Pods (ClusterIP, NodePort, LoadBalancer).
- ConfigMap & Secret: decouple config and sensitive data from images.
- PersistentVolume (PV) & PersistentVolumeClaim (PVC): storage abstraction backed by network storage.
- Namespace: logical cluster partitioning for isolation and multi-tenancy.
- RBAC: role-based access control for API access and least-privilege.

---

## Real-world / production notes — the hard-won lessons

These are practical tips I use daily when running clusters in production:

- Resource Requests & Limits: Always set `requests` and `limits`. Requests drive scheduling; limits prevent noisy neighbours.
- Liveness vs Readiness: Use readiness probes to control traffic during startup and liveness probes to recover from deadlocks.
- Rolling upgrades & rollbacks: Prefer `kubectl rollout` and test rollbacks in a staging cluster.
- Use Namespaces + ResourceQuotas to limit blast radius and avoid runaway costs.
- Observability: run Prometheus + Alertmanager + Grafana and centralised logs (ELK/EFK or Loki) from day one.
- Backups: etcd backups are critical. Test restore drills regularly — not optional.
- Upgrade strategy: control plane first, then nodes; follow Kubernetes version skew policy; automate with CI.
- Pod Disruption Budgets (PDB): protect availability during node drains and upgrades.
- Network Policies: enforce least privilege network access between pods in production.
- Secret management: integrate with a secret store (Vault, cloud KMS) for sensitive keys; avoid baking secrets into images.
- Autoscaling: use HPA/VPA for horizontal/vertical scaling, but monitor for oscillations and set sensible thresholds.
- Use immutable container images and image digests for reproducible rollouts.

Real example: I once had a noisy batch job without CPU limits. It saturated the node, evicted critical services, and caused cascading failures. Setting CPU requests/limits and using dedicated node pools for batch jobs prevented recurrence.

---

## Quick commands to run (try these locally with Minikube / kind / cloud cluster)

kubectl basics:

```bash
kubectl version --short
kubectl get nodes
kubectl get pods -A
kubectl describe pod <pod-name>
kubectl logs deployment/<deployment-name>
kubectl apply -f ./nginx-deployment.yaml
kubectl rollout status deployment/nginx
kubectl get svc -A
```

If you use `kind` or `minikube`, create a cluster and apply the example below to see a rolling deployment.

---

## Minimal Deployment + Service example

Save as `nginx-deployment.yaml` and apply with `kubectl apply -f nginx-deployment.yaml`.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
	name: nginx
spec:
	replicas: 2
	selector:
		matchLabels:
			app: nginx
	template:
		metadata:
			labels:
				app: nginx
		spec:
			containers:
			- name: nginx
				image: nginx:stable
				ports:
				- containerPort: 80
				readinessProbe:
					httpGet:
						path: /
						port: 80
					initialDelaySeconds: 5
					periodSeconds: 10

---
apiVersion: v1
kind: Service
metadata:
	name: nginx-svc
spec:
	type: ClusterIP
	selector:
		app: nginx
	ports:
	- port: 80
		targetPort: 80
```

---

## Day-1 learning roadmap (what to study next)

1. Get hands-on: start a local cluster with `kind` or `minikube` and deploy the example above.
2. Learn `kubectl` (get/describe/logs/exec/port-forward/rollout).
3. Deep dive into Pod lifecycle, probes, and resource management.
4. Study Services, DNS, and a CNI plugin (e.g., Calico or Cilium basics).
5. Explore persistent storage (PVC/PV) and an example stateful app.
6. Set up basic observability: Prometheus + Grafana and a logging stack.

---

## Closing notes (for LinkedIn readers)

Kubernetes unlocks velocity and resilience but adds operational complexity. Start small, automate everything you can, and treat the cluster as critical infrastructure — with backups, alerts, and tested upgrades.

If you'd like, I'll post Day-2 covering Deployments, ReplicaSets, and how to design health checks and rollout strategies for zero-downtime updates. Hit like/follow if this was useful and share what you want to learn next!

---

Files in this folder:

- `nginx-deployment.yaml` — quick example to try locally (included above)