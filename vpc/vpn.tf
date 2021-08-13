resource "aws_ec2_client_vpn_endpoint" "client_vpn" {
  description            = "kerezov-clientvpn-${var.env}"
  server_certificate_arn = aws_acm_certificate.server_side_vpn.arn
  client_cidr_block      = "10.0.0.0/16"
  dns_servers            = ["8.8.8.8", "8.8.4.4"]
  transport_protocol     = "tcp"

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.client_side_vpn.arn
  }

  connection_log_options {
    enabled = false
  }
  tags = { Name = "kerezov-clientvpn-${var.env}" }
}

# resource "aws_ec2_client_vpn_network_association" "client_vpn" {
#   count                  = length(module.vpc.private_subnets)
#   client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn.id
#   subnet_id              = module.vpc.private_subnets[count.index]
#   security_groups        = [module.sg_vpn.this_security_group_id]
# }