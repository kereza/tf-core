output "azs" {
  description = "List of availability zones that we use"
  value       = local.azs
}
output "cidr" {
  description = "VPC CIDR"
  value       = local.cidr
}
output "vpc_id" {
  description = "Export VPC ID"
  value       = module.vpc.vpc_id
}
output "env" {
  description = "Export environment name"
  value       = var.env
}

/*
  SUBNETS
  */
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = module.vpc.database_subnets
}

output "database_subnets_cidr_blocks" {
  description = "List of cidr_blocks of database subnets"
  value       = module.vpc.database_subnets_cidr_blocks
}

output "database_subnet_group" {
  description = "ID of database subnet group"
  value       = module.vpc.database_subnet_group
}

/*
VPN
*/
output "client_key_pem" {
  description = "Materia for the client key"
  value       = tls_private_key.client_side_vpn.private_key_pem
}

output "client_cert_pem" {
  description = "Material for the cleint cert"
  value       = tls_locally_signed_cert.client_side_vpn.cert_pem
}