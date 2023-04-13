resource "aws_eks_cluster" "devops-eks" {
 name = "${var.project}-cluster"
 role_arn = aws_iam_role.cluster.arn

 vpc_config {
  subnet_ids = var.subnet_id_list
 }
 depends_on = [
  aws_iam_role.cluster,
 ]
}

# output "kubeconfig-certificate-authority-data" {
#   value = aws_eks_cluster.devops-eks.certificate_authority[0].data
# }
