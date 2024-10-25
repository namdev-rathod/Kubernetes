# Step 1. Terraform VPC Project
This Terraform project defines and provisions a Virtual Private Cloud (VPC) in a cloud provider environment.

The main purpose of this project is to create a VPC with associated networking components such as subnets, route tables, and security groups. The infrastructure can be customized based on your requirements.

## Prerequisites
1. Install terrafrom binary (https://www.terraform.io/downloads.html)
2. Configure AWS cli (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
3. Create S3 bucket for to storing tfstate and update the details in backend.tf

## Configuration
  1. clone repo from git
  2. configure backend.tf fin in vpc directory 
        ```
            terraform {
                backend "s3" {
                    region  = <REGION>
                    bucket  = <S3_BUCKET_NAME>
                    key     = "<FILE_NAME>.tfstate"
                    encrypt = true
                 }
            }
        ```
  3. change variables as per you requirments in  terraform.tfvars or variable.tf (default value only)

## Usage
To create the VPC and associated resources run the follwing command

        cd vpc 
        terraform init
        terraform apply
    
## Destroy
    
     terraform destroy
    

# Step 2. Terraform EKS Project 
To setup eks we need to run vpc first 

## Prerequisites
1. Step 1 should be excute first
2. configure backend file to read vpc id and subnets 

        terraform {
            backend "s3" {
                region  = "<Bucket_Region>"
                bucket  = "<Bucket_Name>"
                key     = "<State_File_Name>.tfstate"
                encrypt = true
            }
        }

        data "terraform_remote_state" "vpc" {
            backend = "s3"
            config = {
                region = "<VPC_Bucket_Region_Name>"
                bucket  = "<VPC_Bucket_Name>" # This value same as a backend section from step 1
                key     = "<VPC_State_File_Name>"
            }
        }

## Usage
To create the VPC and associated resources run the follwing command

        cd eks 
        terraform init
        terraform apply
    
## Destroy
    
     terraform destroy