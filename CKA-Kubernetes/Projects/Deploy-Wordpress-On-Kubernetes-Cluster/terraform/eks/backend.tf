terraform {
  backend "s3" {
    region  = "us-east-1"
    bucket  = "poc-k8s-tf-backend"
    key     = "eks/poc-eks.tfstate"
    encrypt = true
  }
}

data "terraform_remote_state" "vpc" {
   backend = "s3"
   config = {
     region = "us-east-1"
     bucket  = "poc-k8s-tf-backend"
     key     = "vpc/poc-custome-vpc.tfstate"
   }
 }