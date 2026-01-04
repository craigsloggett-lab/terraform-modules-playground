resource "aws_security_group" "elasticache" {
  name        = local.security_group_name
  description = "Security Group for ElastiCache ${var.engine} cluster: ${var.identifier}"
  vpc_id      = data.aws_vpc.selected.id

  tags = {
    Name = local.security_group_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "elasticache_cidr" {
  for_each = toset(var.allowed_cidr_blocks)

  security_group_id = aws_security_group.elasticache.id
  description       = "Allow ${var.engine} traffic ingress to the cache cluster from CIDR: ${each.value}"

  cidr_ipv4   = each.value
  ip_protocol = "tcp"
  from_port   = local.port
  to_port     = local.port
}

resource "aws_vpc_security_group_ingress_rule" "elasticache_sg" {
  for_each = toset(var.allowed_security_group_ids)

  security_group_id = aws_security_group.elasticache.id
  description       = "Allow ${var.engine} traffic ingress to the cache cluster from security group: ${each.value}"

  referenced_security_group_id = each.value
  ip_protocol                  = "tcp"
  from_port                    = local.port
  to_port                      = local.port
}

resource "aws_vpc_security_group_egress_rule" "elasticache" {
  security_group_id = aws_security_group.elasticache.id
  description       = "Allow all outbound traffic from the cache cluster."

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}
