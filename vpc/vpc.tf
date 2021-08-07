module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.0.0"

  name = var.env
  cidr = local.per_env_settings[var.env]["cidr"]

  azs             = local.per_env_settings[var.env]["azs"]
  private_subnets  = local.per_env_settings[var.env]["private_subnets"]
  public_subnets  = local.per_env_settings[var.env]["public_subnets"]
  database_subnets = local.per_env_settings[var.env]["database_subnets"]

  enable_dns_hostnames               = true
  enable_nat_gateway                 = true
  single_nat_gateway                 = local.per_env_settings[var.env]["single_nat_gateway"]
  enable_dhcp_options                = true
  dhcp_options_domain_name           = "ec2.internal"
  dhcp_options_domain_name_servers   = ["AmazonProvidedDNS"]

  tags = local.common_tags
}