/*
Roles and Policies for the EKS Cluster
*/
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

resource "aws_iam_role_policy_attachment" "eks_servicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster.name
}

# Optionally, enable Security Groups for Pods
resource "aws_iam_role_policy_attachment" "eks_vpc_resourcecontroller" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster.name
}

/*
Roles and Policies for the EKS Node group
*/
data "aws_iam_policy_document" "assume_role_eks_node_group" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_node_group" {
  name                 = "UserManaged-${var.env}-eks-node-group"
  path                 = "/"
  assume_role_policy   = data.aws_iam_policy_document.assume_role_eks_node_group.json
  permissions_boundary = "arn:aws:iam::${var.account_id}:policy/MainBoundaryPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_node_group_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "eks_node_group_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "eks_node_group_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group.name
}