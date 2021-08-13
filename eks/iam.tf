data "aws_iam_policy_document" "assume_role_eks" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_cluster" {
  name                 = "UserManaged-${var.env}-eks"
  path                 = "/"
  assume_role_policy   = data.aws_iam_policy_document.assume_role_eks.json
  permissions_boundary = "arn:aws:iam::${var.account_id}:policy/MainBoundaryPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_clusterpolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

# Optionally, enable Security Groups for Pods
resource "aws_iam_role_policy_attachment" "eks_vpc_resourcecontroller" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster.name
}