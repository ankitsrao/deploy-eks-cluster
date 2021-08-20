provider "aws" {
  region = var.region
}

#VPC
module "network" {
  source          = "./network"
  cluster_name    = var.cluster_name
  cidr_block      = var.cidr_block
  vpc_name        = var.vpc_name
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
}

#EKS
module "eks-cluster" {
  source          = "./eks-cluster"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  node_group_name = var.node_group_name
  instance_types  = var.instance_types
  ami_type        = var.ami_type
  disk_size       = var.disk_size
  subnet_ids      = module.network.subnets
  desired_size    = var.desired_size
  min_size        = var.min_size
  max_size        = var.max_size
  region          = var.region
  depends_on      = [module.network]
}
