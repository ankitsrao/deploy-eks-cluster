module "input_parameters" {
  source = "./parameters"
}

provider "aws" {
  region = module.input_parameters.region
}

#VPC
module "network" {
  source          = "./network"
  cluster_name    = module.input_parameters.cluster_name
  cidr_block      = module.input_parameters.cidr_block
  vpc_name        = module.input_parameters.vpc_name
  private_subnets = module.input_parameters.private_subnets
  public_subnets  = module.input_parameters.public_subnets
}

#EKS
module "eks-cluster" {
  source          = "./eks-cluster"
  cluster_name    = module.input_parameters.cluster_name
  cluster_version = module.input_parameters.cluster_version
  node_group_name = module.input_parameters.node_group_name
  instance_types  = module.input_parameters.instance_types
  ami_type        = module.input_parameters.ami_type
  disk_size       = module.input_parameters.disk_size
  subnet_ids      = module.network.subnets
  desired_size    = module.input_parameters.desired_size
  min_size        = module.input_parameters.min_size
  max_size        = module.input_parameters.max_size
  region          = module.input_parameters.region
  depends_on      = [module.network]
}
