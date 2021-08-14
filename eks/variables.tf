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
      instance_types = "t3.large"
    }
    prod = {
      instance_types = "t3.large"
    }
  })

  instance_types = local.per_environment_settings[var.env]["instance_types"]

  tags = { terraform = "true", environment = var.env }
}

