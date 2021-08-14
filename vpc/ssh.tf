data "template_file" "keypair_default" {
  template = file("${path.module}/ssh-keys/${var.env}.pub")
}

resource "aws_key_pair" "default" {
  key_name   = var.env
  public_key = data.template_file.keypair_default.rendered
}