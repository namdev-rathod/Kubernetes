# 🚀 Kubernetes Top 50 Commands (with Real-Time Examples)

This repository contains the **top 50 Kubernetes commands** that DevOps engineers use daily while working with **EKS (Amazon Elastic Kubernetes Service)** or any Kubernetes cluster.  
It includes **real-time examples**, **short descriptions**, and **namespace-specific usage**.  

- **Cluster Name:** `demo-cluster`  
- **Namespace:** `demo-namespace`  

---

## ⚠️ Important Note

These commands are intended for **educational and professional reference only**.  
👉 Please **execute them at your own risk and with proper knowledge** of your cluster environment.  
Running commands in production without understanding the impact may cause outages or data loss.

---


## 📋 Quick Reference (Command + Description)

| Command | Description |
|---------|-------------|
| `kubectl cluster-info` | Display cluster control-plane and service endpoints |
| `kubectl get nodes -o wide` | List all nodes with internal/external IPs |
| `kubectl get pods -n demo-namespace` | List Pods in a namespace |
| `kubectl describe pod <pod-name> -n demo-namespace` | View detailed Pod info (events, IP, node) |
| `kubectl logs -f <pod-name> -n demo-namespace` | Stream Pod logs in real-time |
| `kubectl exec -it <pod-name> -n demo-namespace -- /bin/sh` | SSH into a Pod container |
| `kubectl get deploy -n demo-namespace` | List deployments |
| `kubectl rollout undo deploy/<deployment> -n demo-namespace` | Rollback to previous Deployment revision |
| `kubectl get svc -n demo-namespace` | List all Services |
| `kubectl get hpa -n demo-namespace` | Check Horizontal Pod Autoscaler |
| `kubectl top pod -n demo-namespace` | View Pod CPU/Memory usage |
| `kubectl get all -n demo-namespace` | Get all resources in a namespace |

---

## 🔑 Top 50 Kubernetes Commands with Real-Time Examples

### 🔹 Cluster & Context Management

1. **Check cluster info**
```bash
kubectl cluster-info
````

Shows Kubernetes master and DNS service endpoints for `demo-cluster`.

2. **List all namespaces**

```bash
kubectl get ns
```

3. **Switch to a specific context (EKS cluster)**

```bash
kubectl config use-context demo-cluster
```

4. **Check current context**

```bash
kubectl config current-context
```

---

### 🔹 Nodes & Resources

5. **List all nodes**

```bash
kubectl get nodes -o wide
```

6. **Describe a node**

```bash
kubectl describe node <node-name>
```

7. **Monitor node resource usage**

```bash
kubectl top nodes
```

---

### 🔹 Pod Lifecycle

8. **List Pods in namespace**

```bash
kubectl get pods -n demo-namespace
```

9. **List Pods with IPs and node assignment**

```bash
kubectl get pods -o wide -n demo-namespace
```

10. **Describe a Pod**

```bash
kubectl describe pod <pod-name> -n demo-namespace
```

11. **Delete a Pod**

```bash
kubectl delete pod <pod-name> -n demo-namespace
```

12. **Exec into a running Pod**

```bash
kubectl exec -it <pod-name> -n demo-namespace -- /bin/sh
```

13. **Export Pod YAML**

```bash
kubectl get pod <pod-name> -n demo-namespace -o yaml
```

14. **Tail Pod logs**

```bash
kubectl logs -f <pod-name> -n demo-namespace
```

15. **Check logs from a specific container**

```bash
kubectl logs -f <pod-name> -c <container-name> -n demo-namespace
```

---

### 🔹 Deployments & ReplicaSets

16. **List deployments**

```bash
kubectl get deploy -n demo-namespace
```

17. **Describe deployment**

```bash
kubectl describe deploy <deployment-name> -n demo-namespace
```

18. **Check rollout status**

```bash
kubectl rollout status deploy/<deployment-name> -n demo-namespace
```

19. **Rollback deployment**

```bash
kubectl rollout undo deploy/<deployment-name> -n demo-namespace
```

20. **View rollout history**

```bash
kubectl rollout history deploy/<deployment-name> -n demo-namespace
```

21. **List ReplicaSets**

```bash
kubectl get rs -n demo-namespace
```

22. **List DaemonSets**

```bash
kubectl get ds -n demo-namespace
```

---

### 🔹 Services & Networking

23. **List services**

```bash
kubectl get svc -n demo-namespace
```

24. **Describe a service**

```bash
kubectl describe svc <service-name> -n demo-namespace
```

25. **Port-forward a service locally**

```bash
kubectl port-forward svc/<service-name> 8080:80 -n demo-namespace
```

26. **List ingress resources**

```bash
kubectl get ingress -n demo-namespace
```

27. **Describe ingress**

```bash
kubectl describe ingress <ingress-name> -n demo-namespace
```

---

### 🔹 ConfigMaps & Secrets

28. **List ConfigMaps**

```bash
kubectl get configmap -n demo-namespace
```

29. **Describe ConfigMap**

```bash
kubectl describe configmap <configmap-name> -n demo-namespace
```

30. **List Secrets**

```bash
kubectl get secrets -n demo-namespace
```

31. **Describe a Secret**

```bash
kubectl describe secret <secret-name> -n demo-namespace
```

32. **Decode a Secret**

```bash
kubectl get secret <secret-name> -n demo-namespace -o jsonpath="{.data.<key>}" | base64 --decode
```

---

### 🔹 Debugging & Troubleshooting

33. **List events in namespace**

```bash
kubectl get events -n demo-namespace --sort-by='.lastTimestamp'
```

34. **Describe failed Pod**

```bash
kubectl describe pod <pod-name> -n demo-namespace
```

35. **Generate YAML with dry-run**

```bash
kubectl create deploy test --image=nginx -n demo-namespace --dry-run=client -o yaml
```

36. **Run a temporary debug Pod**

```bash
kubectl run tmp-shell --rm -it --image=busybox -n demo-namespace -- /bin/sh
```

---

### 🔹 Scaling & Autoscaling

37. **Scale deployment manually**

```bash
kubectl scale deploy <deployment-name> --replicas=5 -n demo-namespace
```

38. **List Horizontal Pod Autoscalers (HPA)**

```bash
kubectl get hpa -n demo-namespace
```

39. **Describe HPA**

```bash
kubectl describe hpa <hpa-name> -n demo-namespace
```

40. **Watch live scaling in action**

```bash
kubectl get hpa -w -n demo-namespace
```

41. **Check cluster autoscaler logs**

```bash
kubectl logs -f deployment/cluster-autoscaler -n kube-system
```

---

### 🔹 Rollouts & Control

42. **Pause rollout**

```bash
kubectl rollout pause deploy/<deployment-name> -n demo-namespace
```

43. **Resume rollout**

```bash
kubectl rollout resume deploy/<deployment-name> -n demo-namespace
```

44. **Show rollout history**

```bash
kubectl rollout history deploy/<deployment-name> -n demo-namespace
```

---

### 🔹 Monitoring & Resources

45. **Check Pod resource usage**

```bash
kubectl top pod -n demo-namespace
```

46. **Check node resource usage**

```bash
kubectl top nodes
```

47. **List available API resources**

```bash
kubectl api-resources
```

48. **List available API versions**

```bash
kubectl api-versions
```

49. **Explain resource definition**

```bash
kubectl explain pod
```

50. **Get all resources in namespace**

```bash
kubectl get all -n demo-namespace
```

---

## 📺 Learn More

* **YouTube Channel (DevOps With Namdev):**
  [https://www.youtube.com/@namdev.devops](https://www.youtube.com/@namdev.devops)

* **Join WhatsApp Channel for Daily Free Tips:**
  [https://whatsapp.com/channel/0029VbCFJhi1CYoN35Hljy2R](https://whatsapp.com/channel/0029VbCFJhi1CYoN35Hljy2R)

---

💡 *Star this repo if you find it helpful!* ⭐

```