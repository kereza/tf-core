output "default_id" {
  description = "SG id default"
  value       = module.sg_default.this_security_group_id
}

output "eks_id" {
  description = "SG for the EKS cluster"
  value       = module.sg_eks.this_security_group_id
}