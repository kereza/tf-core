variable "account_id" {
  description = "Id of the AWS account to assume role. It is a TF cloud variable, coming from the master workspace"
  type        = string
}

variable "region" {
  description = "The default region in which we build infrastructure. It is a TF cloud variable, coming from the master workspace"
  type        = string
}

variable "env" {
  description = "The current env. It is a TF cloud variable, coming from the master workspace"
  type        = string
}

locals {
  per_environment_settings = tomap({
    dev = {
      cidr               = "10.2.0.0/16"
      azs                = ["eu-central-1a", "eu-central-1b"]
      private_subnets    = ["10.2.4.0/23", "10.2.68.0/23"]
      public_subnets     = ["10.2.0.0/24", "10.2.64.0/24"]
      database_subnets   = ["10.2.8.0/24", "10.2.76.0/24"]
      single_nat_gateway = true
    }
    prod = {
      cidr               = "10.4.0.0/16"
      azs                = ["eu-central-1a", "eu-central-1b"]
      private_subnets    = ["10.4.4.0/23", "10.4.68.0/23"]
      public_subnets     = ["10.4.0.0/24", "10.4.64.0/24"]
      database_subnets   = ["10.4.8.0/24", "10.4.76.0/24"]
      single_nat_gateway = true
    }
  })

  cidr               = local.per_environment_settings[var.env]["cidr"]
  azs                = local.per_environment_settings[var.env]["azs"]
  private_subnets    = local.per_environment_settings[var.env]["private_subnets"]
  public_subnets     = local.per_environment_settings[var.env]["public_subnets"]
  database_subnets   = local.per_environment_settings[var.env]["database_subnets"]
  single_nat_gateway = local.per_environment_settings[var.env]["single_nat_gateway"]

  tags = { terraform = "true", environment = var.env }
}

