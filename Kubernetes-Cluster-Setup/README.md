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

1. **Create IAM User With Access Key & Secret Key**
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

2. **Install AWS CLI**
    - Visit Link - https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
    - Download AWS CLI Based On The OS

    ![alt text](image-5.png)

    - For Windows Expand It & Download EXE

    ![alt text](image-6.png)

    - Once Download Completed Then Install It

    - Check AWS CLI Version - aws --version

    ![alt text](image-7.png)

3. **Install Kubectl**
    - Visit Link https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html
    - Install Kubernetes 1.29 Version By Command Line 
    - curl.exe -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/windows/amd64/kubectl.exe
    - Once Installed Kubectl. Check Version # kubectl version --client
    
    ![alt text](image-8.png)

4. **Install Eksctl**
    - Visit Link - https://eksctl.io/installation/
    - Download EXE - AMD64/x86_64

    ![alt text](image-9.png)

    - Once Downloaded Then Unzip It

    ![unzip](image-10.png)

    - Rename Folder eksctl_Windows_amd64 to eksctl
    - Copy & Paste Into C:\Program Files\eksctl

    ![alt text](image-11.png)

5. **Configure Environment Variable**
    - Open Control Panel
    - Click On System

    ![system](image-12.png)

    - Click On Advanced System Settings

    ![alt text](image-13.png)

    - Click On Environment Variables

    ![variables](image-14.png)

    - Select Path & Click On Edit

    ![alt text](image-15.png)

    - Add Eksctl Path & Click Ok

    ![alt text](image-16.png)

6. **Create EKS Cluster By Eksctl**
    - Use Below Command To Create EKS Cluster
    
    ```
    eksctl create cluster --name demo-cluster --version 1.29 --region ap-south-1 --nodegroup-name standard-workers --node-type t3.medium --nodes 2 --managed

    ```


