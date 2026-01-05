# Application Load Balancer
resource "aws_lb" "this" {
  name               = local.alb_name
  load_balancer_type = "application"
  internal           = var.internal
  subnets            = var.subnet_ids
  security_groups    = [aws_security_group.alb.id]

  enable_deletion_protection       = var.enable_deletion_protection
  enable_http2                     = var.enable_http2
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  drop_invalid_header_fields       = var.drop_invalid_header_fields
  idle_timeout                     = var.idle_timeout
  ip_address_type                  = var.ip_address_type

}

# Target Group
resource "aws_lb_target_group" "this" {
  name                 = local.target_group_name
  port                 = var.target_group_port
  protocol             = var.target_group_protocol
  vpc_id               = data.aws_vpc.selected.id
  target_type          = var.target_type
  deregistration_delay = var.deregistration_delay
  slow_start           = var.slow_start

  health_check {
    enabled             = var.health_check_enabled
    protocol            = var.health_check_protocol
    path                = var.health_check_path
    port                = var.health_check_port
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    matcher             = var.health_check_matcher
  }

  lifecycle {
    create_before_destroy = true
  }
}

# HTTPS Listener
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  ssl_policy        = var.listener_protocol == "HTTPS" ? var.ssl_policy : null
  certificate_arn   = var.listener_protocol == "HTTPS" ? var.certificate_arn : null

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
