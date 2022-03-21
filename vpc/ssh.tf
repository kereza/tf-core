resource "aws_key_pair" "default" {
  key_name   = var.env
  public_key = templatefile("${path.module}/ssh-keys/${var.env}.pub", {})
}