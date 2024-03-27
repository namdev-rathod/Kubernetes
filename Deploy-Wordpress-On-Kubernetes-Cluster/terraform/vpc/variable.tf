variable "region" {default = "us-east-1"}
variable "vpc_cidr" {
  description = "VPC cidir block"
  default     = "10.0.0.0/16"
}
variable "tags" {
  description = "VPC tags name"
  default = {
    "Name"  = "poc-vpc"
    "Owner" = "Terraform"
  }
}
variable "vpc_name" {
  description = "VPC NAME"
  default     = "poc-vpc"
}

variable "public-subnet-zone" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  description = "List the public subnet zone name it must be same count as cidr"
}
variable "public-cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  description = "List the public subnet CIDR it must be same count as zone name"
}
variable "private-subnet-zone" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  description = "List the private subnet zone name it must be same count as cidr"
}
variable "private-cidr" {
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  description = "List the private subnet CIDR it must be same count as zone name"
}
#variable "private-zone-name" { description = "private hosted zone" }