variable "cluster_name" {
  description = "EKS cluster name"
  default     = "demo-eks-cluster"
}

variable "vpc_name" {
  description = "VPC name"
  default     = "demo-vpc"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  default     = []
}

variable "private_subnets" {
  type        = list(string)
  description = "Private Subnets CIDR"
  default     = []
}

variable "public_subnets" {
  type        = list(string)
  description = "Public Subnets CIDR"
  default     = []
}