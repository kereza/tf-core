module "sg_default" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.17.0"
  name        = "SG default for default services ${var.env}"
  description = "Default Security Group"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  # Ingress rules taken from the module
  ingress_cidr_blocks = ["10.0.0.0/8"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp", "ssh-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  tags = {
    Name = "defaul-${var.env}"
  }
}

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