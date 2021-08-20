output "eks_id" {
  description = "SG for the EKS cluster"
  value       = module.sg_eks.this_security_group_id
}

output "eks_private_endpoint_id" {
  description = "SG for the private EKS endpoint"
  value       = module.sg_eks_private_endpoint.this_security_group_id
}

output "eks_nodes_ssh" {
  description = "SG for the EKS workers for SSH access"
  value       = module.sg_eks_nodes.this_security_group_id
}

/*
KMS
*/
output "ecr_kms_key_id" {
  description = "KMS key for ECR"
  value       = aws_kms_key.ecr.key_id
}

output "ecr_kms_key_arn" {
  description = "KMS key for ECR"
  value       = aws_kms_key.ecr.arn
}