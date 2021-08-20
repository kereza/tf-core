module "sg_eks" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.17.0"
  name        = "SG for the ${var.env} EKS cluster"
  description = "SG for the EKS cluster"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  # Ingress rules taken from the module
  ingress_cidr_blocks = [data.terraform_remote_state.vpc.outputs.cidr]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  tags = {
    Name = "eks-${var.env}"
  }
}

module "sg_eks_private_endpoint" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.17.0"
  name        = "SG for the ${var.env} EKS Private Endpoint"
  description = "SG for the EKS Private Endpoint"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  # Ingress rules taken from the module
  ingress_cidr_blocks = ["10.0.0.0/16"]
  ingress_rules       = ["https-443-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  tags = {
    Name = "eks-private-endpoint-${var.env}"
  }
}

module "sg_eks_nodes" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.17.0"
  name        = "SG for the ${var.env} EKS worker nodes"
  description = "SG for the EKS worker nodes"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "ssh-tcp"
      source_security_group_id = data.terraform_remote_state.vpn.outputs.sg_vpn_id
      description              = "Access from VPN Only"
    }
  ]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  tags = {
    Name = "eks-nodes-ssh-${var.env}"
  }
}