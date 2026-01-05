module "s3_storage" {
  source  = "app.terraform.io/craigsloggett-lab/s3-bucket/aws"
  version = "1.0.0"

  bucket_name = local.s3_bucket_name
}

module "database" {
  source = "../../terraform-aws-rds-postgres"

  identifier = "${var.name_prefix}-postgres-db"
  vpc_id     = data.aws_vpc.tfe.id
  subnet_ids = data.aws_subnets.private_data.ids

  database_name = var.database_name

  postgres_version                      = "17.7"
  allowed_cidr_blocks                   = [data.aws_vpc.tfe.cidr_block]
  backup_retention_period               = 0
  deletion_protection                   = false
  skip_final_snapshot                   = true
  database_insights_mode                = "advanced"
  performance_insights_retention_period = 465

}

module "cache" {
  source = "../../terraform-aws-elasticache"

  identifier = "${var.name_prefix}-cache"
  vpc_id     = data.aws_vpc.tfe.id
  subnet_ids = data.aws_subnets.private_data.ids

  engine = var.cache_engine

  num_cache_clusters         = 2
  automatic_failover_enabled = true
  multi_az_enabled           = true

  allowed_cidr_blocks = [data.aws_vpc.tfe.cidr_block]

  snapshot_retention_limit = 7
}

module "iam" {
  source = "../../terraform-aws-tfe-iam"

  identifier = var.name_prefix

  s3_bucket_arn = module.s3_storage.bucket_arn

  ssm_parameter_arns = [
    "arn:aws:ssm:${local.region}:${local.account_id}:parameter/TFE/*"
  ]

  secrets_manager_secret_arns = [
    module.database.user_password_secret_arn,
  ]
}

module "alb" {
  source = "../../terraform-aws-alb"

  identifier      = var.name_prefix
  vpc_id          = data.aws_vpc.tfe.id
  subnet_ids      = data.aws_subnets.public.ids
  certificate_arn = aws_acm_certificate_validation.tfe.certificate_arn

  internal                   = false
  enable_deletion_protection = var.enable_deletion_protection
  drop_invalid_header_fields = true

  listener_port     = 443
  listener_protocol = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"

  target_group_port     = 443
  target_group_protocol = "HTTPS"

  health_check_enabled             = true
  health_check_protocol            = "HTTPS"
  health_check_path                = "/_health_check"
  health_check_interval            = 60
  health_check_timeout             = 5
  health_check_healthy_threshold   = 2
  health_check_unhealthy_threshold = 10
  health_check_matcher             = "200"

  allowed_cidr_blocks = var.allowed_cidr_blocks

  depends_on = [aws_acm_certificate_validation.tfe]
}

module "asg" {
  source = "../../terraform-aws-ec2-asg"

  identifier = var.name_prefix
  vpc_id     = data.aws_vpc.tfe.id
  subnet_ids = data.aws_subnets.private_app.ids
  ami_id     = data.aws_ami.debian.id

  instance_type            = var.instance_type
  aws_key_pair_name        = aws_key_pair.this.key_name
  iam_instance_profile_arn = module.iam.instance_profile_arn
  user_data                = var.user_data_script

  root_volume_type       = "gp3"
  root_volume_size       = 100
  root_volume_iops       = 3000
  root_volume_throughput = 125
  root_volume_encrypted  = true

  http_tokens   = "required"
  http_endpoint = "enabled"

  enable_monitoring = true
  ebs_optimized     = true

  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  desired_capacity          = var.asg_desired_capacity
  health_check_type         = "ELB"
  health_check_grace_period = 300

  target_group_arns = [module.alb.target_group_arn]

  ingress_rules = [
    {
      description = "Allow HTTPS traffic ingress to the TFE Hosts from all networks."
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "tcp"
      from_port   = 443
      to_port     = 443
    },
    {
      description = "Allow SSH traffic ingress to the TFE Hosts from private subnets."
      cidr_ipv4   = "10.0.0.0/16"
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
    },
    {
      description = "Allow Vault traffic ingress to the TFE Hosts from private subnets."
      cidr_ipv4   = "10.0.0.0/16"
      ip_protocol = "tcp"
      from_port   = 8201
      to_port     = 8201
    }
  ]

  depends_on = [
    module.database,
    module.cache,
    module.s3_storage,
    module.config
  ]
}
