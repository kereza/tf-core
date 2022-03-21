resource "aws_key_pair" "default" {
  key_name   = var.environment
  public_key = templatefile("${path.module}/ssh-keys/${var.env}.pub", {})
}