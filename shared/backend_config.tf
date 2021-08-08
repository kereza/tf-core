# Shared file. It is ONLY used when we are doing CLI runs
# NOT used in Terraform Cloud
terraform {
  backend "remote" {
    organization = "main-organization"

  }
}

