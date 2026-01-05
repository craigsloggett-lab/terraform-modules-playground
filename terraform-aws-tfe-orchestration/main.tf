# S3 Bucket for TFE Object Storage
module "s3_storage" {
  source  = "app.terraform.io/craigsloggett-lab/s3-bucket/aws"
  version = "1.0.0"

  bucket_name        = local.s3_bucket_name
  versioning_enabled = true

  lifecycle_rules = [
    {
      id      = "expire-old-versions"
      enabled = true

      noncurrent_version_expiration_days = 90

      noncurrent_version_transitions = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        }
      ]
    }
  ]

  force_destroy = var.force_destroy_s3

  tags = local.common_tags
}

# RDS PostgreSQL Database
module "database" {
  source = "../../terraform-aws-rds-postgres"

  identifier = "${var.name_prefix}-postgres-db"
  vpc_id     = data.aws_vpc.tfe.id
  subnet_ids = data.aws_subnets.private_data.ids

  database_name = var.database_name
  username      = var.database_username

  instance_class    = var.database_instance_class
  allocated_storage = var.database_allocated_storage

  allowed_cidr_blocks = var.create_vpc ? [module.vpc[0].vpc_cidr_block] : []

  deletion_protection = var.enable_deletion_protection
  skip_final_snapshot = var.skip_final_snapshot

  tags = local.common_tags
}

# ElastiCache for Redis/Valkey
module "cache" {
  source = "../../terraform-aws-elasticache"

  identifier = "${var.name_prefix}-cache"
  vpc_id     = data.aws_vpc.tfe.id
  subnet_ids = data.aws_subnets.private_data.ids

  engine    = var.cache_engine
  node_type = var.cache_node_type

  num_cache_clusters         = 2
  automatic_failover_enabled = true
  multi_az_enabled           = true

  allowed_cidr_blocks = var.create_vpc ? [module.vpc[0].vpc_cidr_block] : []

  tags = local.common_tags
}

# IAM Role and Instance Profile
module "iam" {
  source = "../../terraform-aws-tfe-iam"

  identifier = var.name_prefix

  s3_bucket_arn = module.s3_storage.bucket_arn

  ssm_parameter_arns = [
    "arn:aws:ssm:${local.region}:${local.account_id}:parameter/TFE/*"
  ]

  secrets_manager_secret_arns = [
    module.database.user_password_secret_arn,
    module.cache.auth_token
  ]

  enable_ec2_metadata_modification = true
  enable_kms_access                = true
  enable_cloudwatch_logs           = true

  tags = local.common_tags
}

# Application Load Balancer
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

  tags = local.common_tags

  depends_on = [aws_acm_certificate_validation.tfe]
}

# Auto Scaling Group
module "asg" {
  source = "../../terraform-aws-ec2-asg"

  identifier = var.name_prefix
  vpc_id     = data.aws_vpc.tfe.id
  subnet_ids = data.aws_subnets.private_app.ids
  ami_id     = var.instance_ami_id != null ? var.instance_ami_id : data.aws_ami.debian.id

  instance_type            = var.instance_type
  key_name                 = var.ssh_key_name
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
      description     = "HTTPS from ALB"
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      security_groups = [module.alb.security_group_id]
    }
  ]

  tags = local.common_tags

  instance_tags = {
    Role = "TFE-Application-Server"
  }

  depends_on = [
    module.database,
    module.cache,
    module.s3_storage,
    module.config
  ]
}
