resource "aws_kms_key" "security" {
  description             = "This key is used to encrypt server side objects"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_kms_key" "this" {
  description             = "KMS key for system wide encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_kms_alias" "this" {
  name          = "alias/test2"
  target_key_id = aws_kms_key.this.key_id
}