terraform {
  backend "s3" {
    region  = "us-east-1"
    bucket  = "poc-k8s-tf-backend"
    key     = "vpc/poc-custome-vpc.tfstate"
    encrypt = true
  }
}