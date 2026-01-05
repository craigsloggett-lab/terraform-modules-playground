locals {
  # Resource naming with defaults
  alb_name            = var.alb_name != null ? var.alb_name : var.identifier
  target_group_name   = var.target_group_name != null ? var.target_group_name : "${var.identifier}-tg"
  security_group_name = var.security_group_name != null ? var.security_group_name : "${var.identifier}-alb-sg"
}
