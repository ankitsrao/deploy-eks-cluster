data "aws_availability_zones" "available" {}

#Deploys VPC that will host the EKS cluster
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.cidr_block

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = false

  vpc_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  enable_dns_hostnames = true
  enable_dns_support   = true
}

output "subnets" {
  value = concat(module.vpc.public_subnets, module.vpc.private_subnets)
}
