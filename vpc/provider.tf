terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.2"
    }
  }
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/OrganizationAccountCloudOpsAccessRole"
  }
  region = var.region
}