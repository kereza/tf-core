module "sg_vpn" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "3.17.0"
  name        = "SG for the VPN connection"
  description = "Security Group for the VPN ${var.env}"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 5543
      to_port     = 5543
      protocol    = "tcp"
      description = "AS2"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  tags = {
    Name = "VPN-${var.env}"
  }
}