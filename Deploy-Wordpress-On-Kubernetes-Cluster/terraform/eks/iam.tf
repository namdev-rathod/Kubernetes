resource "aws_iam_role" "iam-role" {
  name = "poc-eks-cluster"
  tags = {
    tag-key = "poc-eks-cluster"
  }

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "eks.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "iam-policy" {
  role       = aws_iam_role.iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "iam-node" {
  name = "poc-eks-nodes"

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

resource "aws_iam_role_policy_attachment" "node-worker" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.iam-node.name
}

resource "aws_iam_role_policy_attachment" "node-cni" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.iam-node.name
}

resource "aws_iam_role_policy_attachment" "node-ecr" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.iam-node.name
}
resource "aws_iam_role_policy_attachment" "node-ec2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = aws_iam_role.iam-node.name
}



data "aws_iam_policy_document" "eks-csi-policy" {
    version = "2012-10-17"
    statement {
        effect = "Allow"
        principals {
            identifiers = [aws_iam_openid_connect_provider.eks-oidc.arn]
            type = "Federated"
        }
        actions = ["sts:AssumeRoleWithWebIdentity"]
        condition {
            test = "StringEquals"
            variable = "${aws_iam_openid_connect_provider.eks-oidc.url}:aud"
            values = ["sts.amazonaws.com"]
        }
        condition {
            test = "StringEquals"
            variable = "${aws_iam_openid_connect_provider.eks-oidc.url}:sub"
            values = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
        }

    }
}

resource "aws_iam_role" "csi-driver" {
  name   = "AmazonEKS_EBS_CSI_Driver"
  assume_role_policy = "${data.aws_iam_policy_document.eks-csi-policy.json}"
} 
resource "aws_iam_role_policy_attachment" "csi-driver" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.csi-driver.name
}