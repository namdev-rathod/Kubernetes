# WordPress Deployment in Kubernetes using helm 

## Prerequisites

Before you begin, ensure you have the following prerequisites:

- Kubernetes EKS cluster set up on AWS
- `kubectl` command-line tool installed
- update the  kubeconfig file for an Amazon EKS cluster to local (Note - Required AWS cli access)
    
        aws eks update-kubeconfig --region region-code --name my-cluster
- Setup metrics server in k8s cluster for  Horizontal Pod Autoscaler (https://docs.aws.amazon.com/eks/latest/userguide/metrics-server.html)

          kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
  
- setup helm demon on you local machine (https://helm.sh/docs/intro/install/)

## k8s resources used 
1. PVC (AWS EBS volume to store persistant data)
2. Storage class (EBS volume)
3. Deployment (Mysql & Wordpress pod)
4. Secrets (To store mysql root password)
5. Service (To communicate wodpress to mysql pod and loadbalancer to connect from global network to wordpress)
6. namespace (Define resource limits for the namespace.)
7. HPA (To scale the wordpress pod)

## Usage
To deploy wordpress cluster on kubernet cluster follow the below steps

1. Clone repo
2. go to helm directory
3. To test the code use dry-run command or template command
        cd helm
        helm  template wordpress -f values.yaml .
        
### Deploy
        cd helm
        helm install wordpress -f values.yaml .
### Delete/Destroy 
        cd helm
        helm uninstall wordpress


# Troubleshooting 
1. Check Pod Status:

        kubectl get pods -n <NAMESPACE>
 
   Check the status of WordPress and MySQL pods. Ensure all pods are in a Running state. If any pod is in an error state, investigate logs.
       
        kubectl logs <pod-name> -n <namespace>

2. Verify Services:
    
    Ensure services like WordPress and MySQL are available and have external IPs. If the service is pending or not external, troubleshoot the service configuration.

        kubectl get services -n <namespace>

3. Persistent Volume Claims (PVC):
    
    Ensure PVCs are bound and have the correct storage class. If PVCs are stuck in a pending state, verify the storage class and available storage in the cluster.
    
        kubectl get pvc

4. Logs and Events:

   Review pod descriptions and events for any error messages or issues. This can help identify problems with pod initialization or container startup.

        kubectl describe pod <pod-name> -n <namespace>
        kubectl get events -n <namespace>
    
5. Scaling Issues:

    If using Horizontal Pod Autoscaler (HPA), check the HPA status and logs.

        kubectl get hpa -n <namespace>
        kubectl describe hpa <hpa-name> -n <namespace>
