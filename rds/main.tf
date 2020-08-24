terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 2.3.0"
    }
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!()-+"
  min_lower        = 2
  min_upper        = 2
  min_numeric      = 2
  min_special      = 2
}

# RDS
module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.18.0"

  identifier = lower(var.tag_name)

  multi_az              = true
  engine                = var.db_engine
  engine_version        = "${var.db_version}.${var.db_patch_version}"
  instance_class        = "db.${var.instance_type}"
  storage_type          = var.volume_type
  allocated_storage     = var.volume_size
  max_allocated_storage = format(var.volume_size * 2)
  storage_encrypted     = var.encryption_enabled

  # Database name 'wordpress_production'.
  name = "${lower(var.tag_name)}_${lower(var.tag_env)}"

  # NOTE: Do NOT use 'user' as the value for 'username'.
  username = lower(var.tag_name)

  password          = random_password.db_password.result
  port              = var.db_port
  apply_immediately = false

  vpc_security_group_ids = [module.security_group.this_security_group_id]

  # Maintenance/Backup
  maintenance_window      = "Mon:05:00-Mon:08:00"
  backup_window           = "08:30-11:30"
  backup_retention_period = var.backup_retention

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

  enabled_cloudwatch_logs_exports = ["audit", "general"]

  # DB subnet group
  db_subnet_group_name = var.db_subnet_group

  # DB parameter group
  create_db_option_group    = false
  create_db_parameter_group = true
  family                    = "${var.db_engine}${var.db_version}"

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8"
    },
    {
      name  = "character_set_server"
      value = "utf8"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]

  # DB option group
  major_engine_version = var.db_version

  # Snapshot name upon DB deletion
  skip_final_snapshot = true
  #final_snapshot_identifier = "${lower(var.tag_name)}-final-snapshot"

  # Database Deletion Protection
  deletion_protection = false
}
