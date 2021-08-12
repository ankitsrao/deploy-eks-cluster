output "region" {
  value = "eu-west-1"
}

output "vpc_name" {
  value = "ankit-demo-eks-vpc"
}

output "cluster_name" {
  value = "ankit-demo-eks-cluster"
}

output "cluster_version" {
  value = "1.21"
}

output "node_group_name" {
  value = "ankit-demo-nodegroup"
}

#Input Parameter instance_type and AMI Type currently go hand in hand.
#For each instance type added in the list, a new AMI Type too has to be added.
#Index 0 instance_type will use index 0 ami_type and so on..

output "instance_types" {
  value = ["t2.medium"]
}

output "ami_type" {
  value = [ "AL2_x86_64" ]
}

output "disk_size" {
  value = 100
}

output "desired_size" {
  value = [2]
}

output "min_size" {
  value = [2]
}

output "max_size" {
  value = [5]
}

output "cidr_block" {
  value = "10.0.0.0/16"
}

output "private_subnets" {
  value = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

output "public_subnets" {
  value = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
