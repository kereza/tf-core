module "sg_default" {
    source = "terraform-aws-modules/security-group/aws"
    version = "3.17.0"
    name        = "SG default for default services"
    description = "Default Security Group ${var.env}"
    vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

    # Ingress rules taken from the module
    ingress_cidr_blocks      = ["10.0.0.0/8"]
    ingress_rules            = ["http-80-tcp", "https-443-tcp", "ssh-tcp"]

    egress_cidr_blocks      = ["0.0.0.0/0"]
    egress_rules            = ["all-all"]

    tags = {
        Name = "SG-jenkins-${var.stage_name}"
    }
}