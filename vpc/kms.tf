resource "aws_kms_key" "security" {
  description             = "This key is used to encrypt server side objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}