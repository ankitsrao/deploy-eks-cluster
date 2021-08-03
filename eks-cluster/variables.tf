variable "region" {
  default     = "ap-south-1"
  description = "AWS region"
}

variable "cluster_name" {
  description = "EKS cluster name"
  default     = "demo-eks-cluster"
}

variable "cluster_version" {
  description = "EKS cluster version"
  default     = "1.19"
}

variable "node_group_name" {
  description = "EKS cluster name"
  default     = "demo-nodegroup"
}

variable "instance_types" {
  type        = list(string)
  description = "Node group instance types"
  default     = []
}

variable "ami_type" {
  type        = list(string)
  description = "AMI Types"
  default     = []
}

variable "disk_size" {
  type        = number
  description = "EBS Volume size"
  default     = 1
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

variable "subnet_ids" {
  type        = list(string)
  description = "Public and Private Subnets CIDR"
  default     = []
}