region = "us-west-1"

vpc_name = "cspm-eks-vpc"

cluster_name = "cspm-eks-cluster"

cluster_version = "1.21"

node_group_name = "cspm-eks-nodegroup"

#Input Parameter instance_type and AMI Type currently go hand in hand.
#For each instance type added in the list, a new AMI Type too has to be added.
#Index 0 instance_type will use index 0 ami_type and so on..

instance_types = ["t2.medium"]

ami_type = [ "AL2_x86_64" ]

disk_size = 30

desired_size = [2]

min_size = [2]

max_size = [3]

cidr_block = "10.0.0.0/16"

private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
