# TFE Access
output "tfe_url" {
  description = "The URL to access Terraform Enterprise"
  value       = "https://${local.tfe_hostname}"
}

output "tfe_hostname" {
  description = "The hostname of the TFE installation"
  value       = local.tfe_hostname
}

# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = data.aws_vpc.tfe.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = data.aws_vpc.tfe.cidr_block
}

# Database
output "database_endpoint" {
  description = "The connection endpoint for the database"
  value       = module.database.endpoint
}

output "database_address" {
  description = "The hostname of the database"
  value       = module.database.address
}

output "database_password_secret_arn" {
  description = "The ARN of the secret containing the database password"
  value       = module.database.user_password_secret_arn
}

# Cache
output "cache_primary_endpoint" {
  description = "The primary endpoint for the cache cluster"
  value       = module.cache.primary_endpoint_address
}

output "cache_auth_token" {
  description = "The auth token for the cache cluster"
  value       = module.cache.auth_token
  sensitive   = true
}

# Storage
output "s3_bucket_name" {
  description = "The name of the S3 bucket for TFE object storage"
  value       = module.s3_storage.bucket_id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3_storage.bucket_arn
}

# Load Balancer
output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb.alb_dns_name
}

output "alb_zone_id" {
  description = "The zone ID of the load balancer"
  value       = module.alb.alb_zone_id
}

# Auto Scaling Group
output "asg_name" {
  description = "The name of the Auto Scaling Group"
  value       = module.asg.autoscaling_group_name
}

output "asg_arn" {
  description = "The ARN of the Auto Scaling Group"
  value       = module.asg.autoscaling_group_arn
}

# IAM
output "iam_role_name" {
  description = "The name of the IAM role"
  value       = module.iam.role_name
}

output "iam_role_arn" {
  description = "The ARN of the IAM role"
  value       = module.iam.role_arn
}

output "instance_profile_arn" {
  description = "The ARN of the IAM instance profile"
  value       = module.iam.instance_profile_arn
}

# SSM Parameters
output "ssm_parameter_path" {
  description = "The prefix path for SSM parameters"
  value       = module.config.parameter_path_prefix
}

# Certificate
output "certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = aws_acm_certificate.tfe.arn
}

# Security Groups
output "alb_security_group_id" {
  description = "The ID of the ALB security group"
  value       = module.alb.security_group_id
}

output "instance_security_group_id" {
  description = "The ID of the instance security group"
  value       = module.asg.security_group_id
}

output "database_security_group_id" {
  description = "The ID of the database security group"
  value       = module.database.security_group_id
}

output "cache_security_group_id" {
  description = "The ID of the cache security group"
  value       = module.cache.security_group_id
}
