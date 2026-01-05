output "instance_id" {
  description = "The RDS instance ID"
  value       = module.terraform_aws_rds_postgres.instance_id
}

output "instance_arn" {
  description = "The ARN of the RDS instance"
  value       = module.terraform_aws_rds_postgres.instance_arn
}

output "instance_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = module.terraform_aws_rds_postgres.instance_resource_id
}

output "endpoint" {
  description = "The connection endpoint in address:port format"
  value       = module.terraform_aws_rds_postgres.endpoint
}

output "address" {
  description = "The hostname of the RDS instance"
  value       = module.terraform_aws_rds_postgres.address
}

output "port" {
  description = "The port the database is listening on"
  value       = module.terraform_aws_rds_postgres.port
}

output "database_name" {
  description = "The name of the database"
  value       = module.terraform_aws_rds_postgres.database_name
}

output "username" {
  description = "The username for the database"
  value       = module.terraform_aws_rds_postgres.rds_instance_master_user
  sensitive   = true
}

output "user_password_secret_arn" {
  description = "The ARN of the secret containing the user password"
  value       = module.terraform_aws_rds_postgres.user_password_secret_arn
}

output "user_password_secret_kms_key_id" {
  description = "The KMS key ID used to encrypt the secret containing the user password"
  value       = module.terraform_aws_rds_postgres.user_password_secret_kms_key_id
}

output "availability_zones" {
  description = "The availability zones of the instance (for single-AZ deployments)"
  value       = module.terraform_aws_rds_postgres.availability_zones
}

output "hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance"
  value       = module.terraform_aws_rds_postgres.hosted_zone_id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.terraform_aws_rds_postgres.security_group_id
}

output "security_group_arn" {
  description = "The ARN of the security group"
  value       = module.terraform_aws_rds_postgres.security_group_arn
}

output "subnet_group_name" {
  description = "The db subnet group name"
  value       = module.terraform_aws_rds_postgres.subnet_group_name
}

output "subnet_group_arn" {
  description = "The ARN of the db subnet group"
  value       = module.terraform_aws_rds_postgres.subnet_group_arn
}

output "parameter_group_name" {
  description = "The db parameter group name"
  value       = module.terraform_aws_rds_postgres.parameter_group_name
}

output "parameter_group_arn" {
  description = "The ARN of the db parameter group"
  value       = module.terraform_aws_rds_postgres.parameter_group_arn
}

output "performance_insights_enabled" {
  description = "Whether Performance Insights is enabled"
  value       = module.terraform_aws_rds_postgres.performance_insights_enabled
}

output "cloudwatch_log_groups" {
  description = "Map of CloudWatch log group names"
  value       = module.terraform_aws_rds_postgres.cloudwatch_log_groups
}

output "engine_version_actual" {
  description = "The running version of the database engine"
  value       = module.terraform_aws_rds_postgres.engine_version_actual
}

output "vpc_id" {
  description = "The VPC ID where the RDS instance is deployed"
  value       = module.terraform_aws_rds_postgres.vpc_id
}
