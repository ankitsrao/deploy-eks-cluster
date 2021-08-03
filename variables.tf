variable "region" {
  default     = "ap-south-1"
  description = "AWS region"
}

variable "vpc_name" {
  description = "VPC name"
  default     = "demo-vpc"
}

variable "cluster_name" {
  description = "EKS cluster name"
  default     = "demo-eks-cluster"
}

variable "node_group_name" {
  description = "EKS cluster name"
  default     = "demo-demo-nodegroup"
}

variable "instance_types" {
  type        = list(string)
  description = "Node group instance types"
  default     = []
}

variable "desired_size" {
  type        = list(number)
  description = "Node group desired size"
  default     = []
}

variable "min_size" {
  type        = list(number)
  description = "Node group min size"
  default     = []
}

variable "max_size" {
  type        = list(number)
  description = "Node group max size"
  default     = []
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

variable "subnet_ids" {
  type        = list(string)
  description = "Public and Private Subnets CIDR"
  default     = []
}
