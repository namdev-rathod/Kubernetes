
resource "aws_eks_node_group" "poc-nodes" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "poc-nodes"
  node_role_arn   = aws_iam_role.iam-node.arn
  subnet_ids =  data.terraform_remote_state.vpc.outputs.private-subnet
  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.medium"]
  scaling_config {
    desired_size = 1
    max_size     = 10
    min_size     = 0
  }
  update_config {
    max_unavailable = 1
  }
  labels = {
    type = "web"
  }
  depends_on = [
    aws_iam_role_policy_attachment.node-worker,
    aws_iam_role_policy_attachment.node-cni,
    aws_iam_role_policy_attachment.node-ecr,
  ]
}
