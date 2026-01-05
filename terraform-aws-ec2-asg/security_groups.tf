resource "aws_security_group" "instances" {
  name        = local.security_group_name
  description = "Security Group for EC2 instances in ASG: ${var.identifier}"
  vpc_id      = data.aws_vpc.selected.id

  tags = {
    Name = local.security_group_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "instances" {
  for_each = { for index, rule in var.ingress_rules : index => rule }

  security_group_id = aws_security_group.instances.id
  description       = each.value.description

  cidr_ipv4   = each.value.cidr_ipv4
  ip_protocol = each.value.ip_protocol
  from_port   = each.value.from_port
  to_port     = each.value.to_port
}

resource "aws_vpc_security_group_egress_rule" "instances" {
  security_group_id = aws_security_group.instances.id
  description       = "Allow all outbound traffic from instances."

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}
