resource "aws_eks_cluster" "eks" {
  name     = var.eks_name
  role_arn = aws_iam_role.iam-role.arn
  version = var.eks_version
  vpc_config {
    subnet_ids = data.terraform_remote_state.vpc.outputs.public-subnet
  }
   depends_on = [aws_iam_role_policy_attachment.iam-policy]
}

resource "aws_eks_addon" "aws-ebs-csi-driver" {
  cluster_name = aws_eks_cluster.eks.name
  addon_name   = "aws-ebs-csi-driver"
 # configuration_values =jsonencode({ 
 #   service-account-role-arn = "arn:aws:iam::YOUR_AWS_ACCOUNT_ID:role/AmazonEKS_EBS_CSI_DriverRole"
 # })
}

output "endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}

data "tls_certificate" "eks" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks-oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks.identity.0.oidc.0.issuer
}