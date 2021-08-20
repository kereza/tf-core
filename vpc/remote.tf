data "terraform_remote_state" "vpn" {
  backend = "remote"

  config = {
    organization = "main-organization"
    workspaces = {
      name = "tf-central-vpn"
    }
  }
}