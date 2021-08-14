output "default_id" {
  description = "SG id default"
  value       = module.sg_default.this_security_group_id
}

output "eks_id" {
  description = "SG for the EKS cluster"
  value       = module.sg_eks.this_security_group_id
}

output "eks_private_endpoint_id" {
  description = "SG for the EKS workers"
  value       = module.sg_eks_private_endpoint.this_security_group_id
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