vpc_cidr = "10.0.0.0/16"
tags = {
  "Name"  = "poc-vpc"
  "Owner" = "Terraform"
}
vpc_name = "poc-vpc"
public-subnet-zone  = ["us-east-1a", "us-east-1b", "us-east-1c"]
public-cidr         = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private-subnet-zone = ["us-east-1a", "us-east-1b", "us-east-1c"]
private-cidr        = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
region = "us-east-1"