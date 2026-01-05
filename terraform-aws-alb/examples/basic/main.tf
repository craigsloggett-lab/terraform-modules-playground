data "aws_vpc" "tfe" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.tfe.id]
  }

  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}

module "terraform_aws_alb" {
  source = "../../"

  identifier      = "tfe-alb-001"
  vpc_id          = data.aws_vpc.tfe.id
  subnet_ids      = data.aws_subnets.public.ids
  certificate_arn = var.certificate_arn

  # ALB Configuration
  internal                   = false
  enable_deletion_protection = false # Set to true for production
  drop_invalid_header_fields = true

  # Listener Configuration
  listener_port     = 443
  listener_protocol = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"

  # Target Group Configuration
  target_group_port     = 443
  target_group_protocol = "HTTPS"
  deregistration_delay  = 300

  # Health Check Configuration
  health_check_enabled             = true
  health_check_protocol            = "HTTPS"
  health_check_path                = "/_health_check"
  health_check_interval            = 60
  health_check_timeout             = 5
  health_check_healthy_threshold   = 2
  health_check_unhealthy_threshold = 10
  health_check_matcher             = "200"

  # Security
  allowed_cidr_blocks = ["0.0.0.0/0"] # Internet-facing
}
