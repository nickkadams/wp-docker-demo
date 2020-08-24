resource "aws_ssm_parameter" "wordpress" {
  name        = "/${var.tag_env}/rds/wordpress/password/main"
  description = "Managed by Terraform"
  type        = "SecureString"
  value       = random_password.db_password.result
  overwrite   = true

  tags = {
    Environment = var.tag_env
    #Contact         = var.tag_cont
    #Cost            = var.tag_cost
    #Customer        = var.tag_cust
    #Project         = var.tag_proj
    Confidentiality = var.tag_conf
    Compliance      = var.tag_comp
    Terraform       = "true"
  }
}
