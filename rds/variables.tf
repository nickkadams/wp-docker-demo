variable "aws_profile" {
  description = "AWS profile"
  type        = string
}

variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region"
  type        = string
}

variable "vpc_name" {
  description = "AWS VPC Tag: name"
  type        = string
}

variable "subnet_name" {
  description = "AWS Security Group Tag: name"
  type        = string
}

variable "db_engine" {
  default     = "mysql"
  description = "Database engine"
  type        = string
}

variable "db_version" {
  default     = 5.7
  description = "Database major and minor version"
  type        = number
}

variable "db_patch_version" {
  default     = 30
  description = "Database patch version"
  type        = number
}

# variable "db_password" {
#   description = "Database password"
#   type        = string
# }

variable "db_port" {
  default     = 3306
  description = "Database port"
  type        = number
}

variable "tag_name" {
  default     = "wordpress"
  description = "Tag: Name"
  type        = string
}

variable "instance_type" {
  default     = "t3.medium"
  description = "RDS instance type"
  type        = string
}

variable "volume_type" {
  default     = "gp2"
  description = "RDS volume type: gp2 or io1"
  type        = string
}

variable "volume_size" {
  default     = 10
  description = "RDS volume size"
  type        = number
}

variable "encryption_enabled" {
  default     = true
  description = "RDS volume encryption: true or false"
  type        = bool
}

variable "backup_retention" {
  default     = 0
  description = "RDS backup retention (days): 0-35"
  type        = number
}

variable "tag_env" {
  default     = "production"
  description = "Tag: Environment"
  type        = string
}

variable "tag_cont" {
  default     = ""
  description = "Tag: Contact"
  type        = string
}

variable "tag_cost" {
  default     = ""
  description = "Tag: Cost"
  type        = string
}

variable "tag_cust" {
  default     = ""
  description = "Tag: Customer"
  type        = string
}

variable "tag_proj" {
  default     = ""
  description = "Tag: Project"
  type        = string
}

variable "tag_conf" {
  default     = "public"
  description = "Tag: Confidentiality"
  type        = string
}

variable "tag_comp" {
  default     = "none"
  description = "Tag: Compliance"
  type        = string
}

variable "db_subnet_group" {
  description = "RDS DB Subnet Group"
  type        = string
}
