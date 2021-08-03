#Deploying AWS EKS node-groups
resource "null_resource" "install_calico" { # The node won't enter the ready state without a CNI initialized
  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/aws/amazon-vpc-cni-k8s/v1.7.5/config/v1.7/calico.yaml"
  }

  depends_on = [null_resource.generate_kubeconfig]
}

#Generates Auth configmap
data "template_file" "aws_auth_configmap" {

  template = file("${path.module}/aws-auth-cm.yaml.tpl")

  vars = {
    arn_instance_role = aws_iam_role.node_group.arn
  }
}

resource "null_resource" "apply_aws_auth_configmap" { # Apply the aws-auth config map

  provisioner "local-exec" {
    command = "echo '${data.template_file.aws_auth_configmap.rendered}' > aws-auth-cm.yaml && kubectl apply -f aws-auth-cm.yaml && rm aws-auth-cm.yaml"
  }


  depends_on = [null_resource.generate_kubeconfig]
}

resource "aws_eks_node_group" "node_group" {

  count          = length(var.instance_types)

  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "${var.node_group_name}-${count.index}"
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = var.subnet_ids
  instance_types  = [ var.instance_types[count.index] ]
  ami_type        = var.ami_type[count.index]
  disk_size       = var.disk_size

  scaling_config {
    desired_size = var.desired_size[count.index]
    max_size     = var.max_size[count.index]
    min_size     = var.min_size[count.index]
  }

  depends_on = [
    null_resource.apply_aws_auth_configmap,
    aws_iam_role_policy_attachment.policy-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.policy-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKSPolicy,
    aws_iam_role_policy_attachment.route53-access
  ]
}

resource "aws_iam_role" "node_group" {
  name = "${var.node_group_name}_role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_policy" "policy" {
  name        = "${var.node_group_name}_route53_access_policy"
  path        = "/"
  description = "Route53 access policy"
  policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Action": [
                  "route53:GetChange",
                  "route53:ChangeResourceRecordSets",
                  "route53:ListResourceRecordSets"
              ],
              "Resource": [
                  "arn:aws:route53:::hostedzone/*",
                  "arn:aws:route53:::change/*"
              ]
          },
          {
              "Effect": "Allow",
              "Action": [
                  "route53:ListHostedZones",
                  "route53:ListResourceRecordSets",
                  "route53:ListHostedZonesByName"
              ],
              "Resource": [
                  "*"
              ]
          }
      ]
  })
}

resource "aws_iam_role_policy_attachment" "policy-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "policy-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group.name
}


resource "aws_iam_role_policy_attachment" "AmazonEKSPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "route53-access" {
  policy_arn = aws_iam_policy.policy.arn
  role       = aws_iam_role.node_group.name
  depends_on = [ aws_iam_policy.policy ]
}