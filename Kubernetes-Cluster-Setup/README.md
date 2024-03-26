# Kubernetes Cluster Setup

> **Steps To Follow EKS Cluster Setup**

1. First Create IAM User with Admin access
2. Generate Access Key and Secret Access Key
3. Install AWS CLI
5. Install Kubectl
6. Install Eksctl
7. Configure environment variables from control panel
8. Create EKS Cluster By Using eksctl

----------------------------------------------------

1. Create IAM User With Access Key & Secret Key
    - Login to AWS console
    - Search IAM service
    - Click on Users
    - Create User - Demo-EKS-User

    ![iam user](image.png)

    ![alt text](image-1.png)

    - Click Next

    - For Practice Grant Administrator Access

    ![alt text](image-2.png)

    - Click Next & Create User

    ![alt text](image-3.png)

    - Click On Demo-EKS-User
    - Click on Security Credentials
    - Generate Access Key & Secret Access Key

    ![alt text](image-4.png)

2. Install AWS CLI