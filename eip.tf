resource "aws_eip_association" "docker" {
  instance_id   = aws_instance.docker[0].id
  allocation_id = aws_eip.docker[0].id
}

resource "aws_eip" "docker" {
  count = var.instance_count

  vpc = true

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
}