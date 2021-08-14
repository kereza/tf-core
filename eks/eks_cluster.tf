module "my-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.1.0"
  cluster_name    = "kerezov-cluster-${var.env}"
  cluster_version = "1.21"
  subnets         = data.terraform_remote_state.vpc.outputs.private_subnets
  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
  cluster_encryption_config = [
    {
      provider_key_arn = data.terraform_remote_state.security.outputs.ecr_kms_key_arn
      resources        = ["secrets"]
    }
  ]

  cluster_create_security_group = false
  cluster_security_group_id     = data.terraform_remote_state.security.outputs.eks_id
  cluster_egress_cidrs          = ["0.0.0.0/0"]

  manage_cluster_iam_resources = false
  cluster_iam_role_name        = aws_iam_role.eks_cluster.name

  # Endpoints For Access
  cluster_endpoint_private_access                = true
  cluster_create_endpoint_private_access_sg_rule = true
  cluster_endpoint_private_access_sg             = [data.terraform_remote_state.security.outputs.eks_private_endpoint_id]
  cluster_endpoint_public_access                 = true
  cluster_endpoint_public_access_cidrs           = ["87.153.134.14/32"]

  # Worker Groups and settings
  node_groups = {
    main1 = {
      desired_capacity    = 1
      max_capacity        = 5
      min_capacity        = 1
      iam_role_arn        = aws_iam_role.eks_node_group.arn
      ami_type            = "AL2_x86_64"
      ami_release_version = "1.21.2-20210722"
      #key_name
      //source_security_group_ids = 

      instance_types = [local.instance_types]
      disk_size      = 50
      capacity_type  = "ON_DEMAND"
      k8s_labels = {
        Environment = var.env
      }
      additional_tags = {
        ExtraTag = "test"
      }
      #   taints = [
      #     {
      #       key    = "dedicated"
      #       value  = "gpuGroup"
      #       effect = "NO_SCHEDULE"
      #     }
      #   ]
    }
  }
  manage_worker_iam_resources = false
  #workers_role_name = aws_iam_role.eks_node_group.name
  worker_create_security_group = false

  write_kubeconfig = false
  manage_aws_auth  = false
  enable_irsa      = true

  #   map_accounts
  #   map_roles
  #   map_users
  tags = local.tags
}