resource "aws_vpc_peering_connection" "keri_org" {
  peer_owner_id = var.account_id
  peer_vpc_id   = data.terraform_remote_state.vpn.outputs.vpc_id
  vpc_id        = module.vpc.vpc_id
  auto_accept   = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}


resource "aws_route" "private_table" {
  count = length(module.vpc.private_route_table_ids)
  route_table_id            = module.vpc.private_route_table_ids[count.index]
  destination_cidr_block    = data.terraform_remote_state.vpn.outputs.cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.keri_org.id
  depends_on                = [module.vpc.private_route_table_ids]

  timeouts {
    create = "5m"
    delete = "2m"
  }
}