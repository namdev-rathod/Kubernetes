# Kubernetes - Troubleshooting's

---

🚀 EKS IRSA Demo (IAM Role for Service Accounts)

This repository demonstrates how to configure IAM Role for Service Accounts (IRSA) in Amazon EKS.
It allows Kubernetes pods to assume an IAM role securely without using node instance profiles. 🛡️


---

📌 Prerequisites

✅ AWS CLI installed and configured

✅ kubectl installed and configured for your EKS cluster

✅ eksctl (optional, for cluster setup)



---

🛠️ Steps to Configure IRSA

1️⃣ Create IAM Role with Trust Policy

Create a file called trust-policy.json:

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::<aws-account>:oidc-provider/<your-oidc-provider>"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "<your-oidc-provider>:sub": "system:serviceaccount:devops-namespace:<service-account>"
        }
      }
    }
  ]
}
```
Create the IAM role:
```
aws iam create-role \
  --role-name devops-role \
  --assume-role-policy-document file://trust-policy.json
```
Attach required policies (example: S3 full access) 🗂️:
```
aws iam attach-role-policy \
  --role-name devops-role \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
```

---

2️⃣ Create Kubernetes Service Account

Create service account:
```
kubectl create serviceaccount <service-account> -n devops-namespace
```
Annotate it with IAM role:
```
kubectl annotate serviceaccount <service-account> \
eks.amazonaws.com/role-arn=arn:aws:iam::<aws-account>:role/devops-role \
-n devops-namespace
```
Verify 🧐:
```
kubectl get sa <service-account> -n devops-namespace -o yaml
```
Expected YAML:
```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: <service-account>
  namespace: devops-namespace
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::<aws-account>:role/devops-role
```

---

3️⃣ Deploy Application 📦

Example deployment manifest:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sample-deployment
  namespace: devops-namespace
spec:
  replicas: 1
  selector:
    matchLabels:
      app: sample-app
  template:
    metadata:
      labels:
        app: sample-app
    spec:
      serviceAccountName: <service-account>
      containers:
        - name: sample-container
          image: nginx:latest
          ports:
            - containerPort: 80
```
Apply the deployment:

kubectl apply -f k8s-deployment.yaml


---

4️⃣ Verify IRSA ✅

Check the pod and IAM role:
```
kubectl describe pod <pod-name> -n devops-namespace | grep -i role
kubectl exec -it <pod-name> -n devops-namespace -- aws sts get-caller-identity
```
You should see the IAM role ARN in the output. 🛡️


---

5️⃣ Notes 📝

Annotations are metadata attached to Kubernetes objects that external controllers (like IRSA) read to allow special behavior.

Labels vs Annotations:


Labels 🏷️	Annotations 📝

Used for selecting or grouping objects	Used for metadata or external tool info
Queryable by kubectl get -l	Not queryable, just metadata
Example: app=frontend	Example: eks.amazonaws.com/role-arn=arn:aws:iam::<aws-account>:role/devops-role


Pro Tip: Always use dedicated IAM roles per service account. Avoid using node instance IAM roles directly in pods. ⚡

---

🎯 Outcome

Pods now securely assume the IAM role via IRSA, no more IMDSv2 issues, and can access AWS resources seamlessly. ✅


