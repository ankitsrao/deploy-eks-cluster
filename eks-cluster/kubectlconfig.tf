#Configuring kubectl CLI

resource "null_resource" "generate_kubeconfig" {

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.cluster_name} --region ${var.region}"
  }

  depends_on = [aws_eks_cluster.cluster]
}
