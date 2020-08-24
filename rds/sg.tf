# Lookup VPC based on tag
data "aws_vpc" "selected" {

  tags = {
    Name = var.vpc_name
  }
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.16.0"

  name            = var.tag_name
  use_name_prefix = false
  description     = "Managed by Terraform"
  vpc_id          = data.aws_vpc.selected.id

  #ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]
  ingress_rules       = ["mysql-tcp"]

  tags = {
    Environment     = var.tag_env
    Contact         = var.tag_cont
    Cost            = var.tag_cost
    Customer        = var.tag_cust
    Project         = var.tag_proj
    Confidentiality = var.tag_conf
    Compliance      = var.tag_comp
    Terraform       = "true"
  }
}
