variable "account_id" {
    description = "Id of the AWS account to assume role. It is a TF cloud variable, coming from the master workspace"
    type = string
}

variable "region" {
    description = "The default region in which we build infrastructure. It is a TF cloud variable, coming from the master workspace"
    type = string
}

variable "env" {
    description = "The current env"
    type = string
}