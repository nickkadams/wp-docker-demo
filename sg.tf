# Lookup VPC based on tag
data "aws_vpc" "selected" {

  tags = {
    Name = var.vpc_name
  }
}

# Get my IP
data "http" "icanhazip" {
  url = "http://icanhazip.com"
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.16.0"

  name            = var.tag_name
  use_name_prefix = false
  description     = "Managed by Terraform"
  vpc_id          = data.aws_vpc.selected.id

  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      description = "SSH"
      cidr_blocks = "${chomp(data.http.icanhazip.body)}/32"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = "${chomp(data.http.icanhazip.body)}/32"
      #cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "HTTPS"
      cidr_blocks = "${chomp(data.http.icanhazip.body)}/32"
      #cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_cidr_blocks      = ["0.0.0.0/0"]
  egress_ipv6_cidr_blocks = []
  egress_rules            = ["all-all"]

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