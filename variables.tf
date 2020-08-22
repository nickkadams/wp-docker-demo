variable "aws_profile" {
  default     = "default"
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

variable "os" {
  default     = "ubuntu"
  description = "OS"
  type        = string
}

variable "os_version" {
  default     = 20.04
  description = "OS version"
  type        = number
}

variable "ami_owner_id" {
  default     = "099720109477"
  description = "AMI OwnerId (self is an option)"
  type        = string
}

variable "instance_count" {
  default     = "1"
  description = "EC2 instance count"
  type        = number
}

variable "tag_name" {
  default     = "docker"
  description = "Tag: Name"
  type        = string
}

variable "instance_type" {
  default     = "t3.medium"
  description = "EC2 instance type"
  type        = string
}

variable "shared_key_name" {
  description = "EC2 key pair name"
  type        = string
}

# variable "instance_profile" {
#   description = "EC2 instance_profile"
#   type        = string
# }

variable "volume_type" {
  default     = "gp2"
  description = "EC2 volume type: standard, gp2, io1, sc1, or st1"
  type        = string
}

variable "volume_size" {
  default     = 15
  description = "EC2 volume size"
  type        = number
}

variable "encryption_enabled" {
  default     = true
  description = "EC2 encryption: true or false"
  type        = bool
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

variable "shared_key_path" {
  description = "SSH path to shared key"
  type        = string
}

variable "ssh_user" {
  default     = "ubuntu"
  description = "SSH username"
  type        = string
}
