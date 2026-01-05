module "tfe" {
  source = "../../"

  name_prefix       = "tfe-${var.environment}"
  route53_zone_name = var.route53_zone_name
  tfe_subdomain     = "tfe"
  tfe_license       = var.tfe_license

  # Create new VPC
  create_vpc = true
  vpc_cidr   = "10.0.0.0/16"

  # Database Configuration
  database_instance_class    = "db.t3.large"
  database_allocated_storage = 100

  # Cache Configuration
  cache_engine    = "valkey"
  cache_node_type = "cache.r7g.large"

  # Compute Configuration
  instance_type        = "t3.xlarge"
  asg_min_size         = 3
  asg_max_size         = 6
  asg_desired_capacity = 3

  # Security
  allowed_cidr_blocks = ["0.0.0.0/0"] # Internet-facing

  # Production settings
  enable_deletion_protection = true
  skip_final_snapshot        = false
  force_destroy_s3           = false

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = "TFE"
  }
}
