````markdown
# 🚀 Daily Use Kubernetes Commands (EKS: demo-cluster)

Here are some of the most useful Kubernetes commands for daily DevOps work with EKS.  
Cluster: **demo-cluster**  
Namespace: **demo-namespace**

---

## 1. Check Pod deployed with which tags/image in ECR
```bash
kubectl get pods -n demo-namespace -o=jsonpath='{..image}'
````

## 2. Rollback Deployment

```bash
kubectl rollout undo deployment <deployment-name> -n demo-namespace
```

## 3. Check Ingress and Pod Events

```bash
kubectl get ingress -n demo-namespace
kubectl describe pod <pod-name> -n demo-namespace
```

## 4. Check Pod Status

```bash
kubectl get pods -o wide -n demo-namespace
```

## 5. Check Pod Logs

```bash
kubectl logs -f <pod-name> -n demo-namespace
```

## 6. Check Autoscaler Logs (KEDA / Cluster Autoscaler)

```bash
kubectl logs -f deployment/cluster-autoscaler -n kube-system
```

## 7. Check HPA Logs

```bash
kubectl get hpa -n demo-namespace
kubectl describe hpa <hpa-name> -n demo-namespace
```

## 8. Check Service Details

```bash
kubectl get svc -n demo-namespace
kubectl describe svc <service-name> -n demo-namespace
```

## 9. Check Pod Configurations (YAML)

```bash
kubectl get pod <pod-name> -n demo-namespace -o yaml
```

## 10. Check Deployment Status

```bash
kubectl rollout status deployment/<deployment-name> -n demo-namespace
```

## 11. Check ReplicaSet and DaemonSet

```bash
kubectl get rs -n demo-namespace
kubectl get ds -n demo-namespace
```

## 12. Check Live Pod Scaling

```bash
kubectl get hpa -w -n demo-namespace
```

---

### 📺 Learn More

* **YouTube Channel (DevOps With Namdev):**
  [https://www.youtube.com/@namdev.devops](https://www.youtube.com/@namdev.devops)

* **Join WhatsApp Channel for Daily Free Tips:**
  [https://whatsapp.com/channel/0029VbCFJhi1CYoN35Hljy2R](https://whatsapp.com/channel/0029VbCFJhi1CYoN35Hljy2R)

---

💡 *Star this repo if you find it helpful!* ⭐

```