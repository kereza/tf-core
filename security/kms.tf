# KMS
resource "aws_kms_key" "ecr" {
  description             = "KMS key for ECR cluster"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "ecr" {
  name          = "alias/ecr-${var.env}"
  target_key_id = aws_kms_key.ecr.key_id
}