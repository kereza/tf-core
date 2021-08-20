data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "main-organization"
    workspaces = {
      name = "vpc-${var.env}"
    }
  }
}

data "terraform_remote_state" "vpn" {
  backend = "remote"

  config = {
    organization = "main-organization"
    workspaces = {
      name = "tf-central-vpn"
    }
  }
}