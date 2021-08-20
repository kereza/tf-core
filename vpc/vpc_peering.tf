resource "aws_route" "private_table" {
  count = length(module.vpc.private_route_table_ids)
  //for_each                  = toset(module.vpc.private_route_table_ids)
  route_table_id            = module.vpc.private_route_table_ids[count.index]
  destination_cidr_block    = data.terraform_remote_state.vpn.outputs.cidr
  vpc_peering_connection_id = data.terraform_remote_state.vpn.outputs.peering_id[var.env]
  depends_on                = [module.vpc.private_route_table_ids]

  timeouts {
    create = "5m"
    delete = "2m"
  }
}