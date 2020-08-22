terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.3.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 1.2.0"
    }
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

# Lookup AMI based on variables
data "aws_ami" "image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${lower(var.os)}/images/hvm-ssd/${lower(var.os)}-*-${var.os_version}-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["${var.ami_owner_id}"]
}

# Lookup subnet(s) based on tag
data "aws_subnet_ids" "selected" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_instance" "docker" {
  count = var.instance_count

  ami                         = data.aws_ami.image.id
  instance_type               = var.instance_type
  subnet_id                   = tolist(data.aws_subnet_ids.selected.ids)[count.index]
  vpc_security_group_ids      = [module.security-group.this_security_group_id]
  key_name                    = var.shared_key_name
  associate_public_ip_address = true
  disable_api_termination     = false

  # credit_specification {
  #   cpu_credits = "standard" # or "unlimited" is default
  # }

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
    encrypted   = var.encryption_enabled
    #iops        = format(var.volume_size * 50)
  }

  tags = {
    Name            = "${var.tag_name}-${format("%02d", count.index + 1)}"
    Environment     = var.tag_env
    Contact         = var.tag_cont
    Cost            = var.tag_cost
    Customer        = var.tag_cust
    Project         = var.tag_proj
    Confidentiality = var.tag_conf
    Compliance      = var.tag_comp
    Terraform       = "true"
  }

  volume_tags = {
    Name            = "${var.tag_name}-${format("%02d", count.index + 1)}"
    Environment     = var.tag_env
    Contact         = var.tag_cont
    Cost            = var.tag_cost
    Customer        = var.tag_cust
    Project         = var.tag_proj
    Confidentiality = var.tag_conf
    Compliance      = var.tag_comp
    Terraform       = "true"
  }

  # Upload template
  provisioner "file" {
    #content     = data.template_file.docker.rendered
    source      = "templates/docker-compose.yml.tpl"
    destination = "/home/${var.ssh_user}/docker-compose.yml"
  }

  # Run commands with remote-exec over ssh
  provisioner "remote-exec" {
    inline = [
      "sleep 15 && sudo apt-get -qqy update",
      "sudo apt-get install -qqy amazon-ecr-credential-helper >/dev/null 2>&1",
      "sudo apt-get install -qqy docker docker-compose gnupg2 net-tools jq pass",
      "sudo sudo usermod -aG docker $USER",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -qqy",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -qqy",
      "sudo apt-get autoremove -qqy",
      "sudo docker-compose -f docker-compose.yml up -d >/dev/null 2>&1"
    ]
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    private_key = file(var.shared_key_path)
    user        = var.ssh_user
    agent       = false
  }
}
