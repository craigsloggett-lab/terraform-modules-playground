resource "aws_security_group" "alb" {
  name        = local.security_group_name
  description = "Security Group for Application Load Balancer: ${var.identifier}"
  vpc_id      = data.aws_vpc.selected.id

  tags = {
    Name = local.security_group_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_cidr" {
  for_each = toset(var.allowed_cidr_blocks)

  security_group_id = aws_security_group.alb.id
  description       = "Allow ${var.listener_protocol} traffic ingress to the ALB from CIDR: ${each.value}"

  cidr_ipv4   = each.value
  ip_protocol = "tcp"
  from_port   = var.listener_port
  to_port     = var.listener_port
}

resource "aws_vpc_security_group_ingress_rule" "alb_sg" {
  for_each = toset(var.allowed_security_group_ids)

  security_group_id = aws_security_group.alb.id
  description       = "Allow ${var.listener_protocol} traffic ingress to the ALB from security group: ${each.value}"

  referenced_security_group_id = each.value
  ip_protocol                  = "tcp"
  from_port                    = var.listener_port
  to_port                      = var.listener_port
}

resource "aws_vpc_security_group_egress_rule" "alb" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow all outbound traffic from the ALB."

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}
