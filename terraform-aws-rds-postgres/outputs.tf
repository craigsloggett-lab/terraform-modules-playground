output "instance_id" {
  description = "The RDS instance ID"
  value       = aws_db_instance.this.id
}

output "instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.this.arn
}

output "instance_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = aws_db_instance.this.resource_id
}

output "endpoint" {
  description = "The connection endpoint in address:port format"
  value       = aws_db_instance.this.endpoint
}

output "address" {
  description = "The hostname of the RDS instance"
  value       = aws_db_instance.this.address
}

output "port" {
  description = "The port the database is listening on"
  value       = aws_db_instance.this.port
}

output "database_name" {
  description = "The name of the database"
  value       = aws_db_instance.this.db_name
}

output "username" {
  description = "The username for the database"
  value       = aws_db_instance.this.username
  sensitive   = true
}

output "user_password_secret_arn" {
  description = "The ARN of the secret containing the user password"
  value       = aws_db_instance.this.master_user_secret[0].secret_arn
}

output "user_password_secret_kms_key_id" {
  description = "The KMS key ID used to encrypt the secret containing the user password"
  value       = aws_db_instance.this.master_user_secret[0].kms_key_id
}

output "availability_zones" {
  description = "The availability zones of the instance (for single-AZ deployments)"
  value       = aws_db_instance.this.availability_zone
}

output "hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance"
  value       = aws_db_instance.this.hosted_zone_id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.rds.id
}

output "security_group_arn" {
  description = "The ARN of the security group"
  value       = aws_security_group.rds.arn
}

output "subnet_group_name" {
  description = "The db subnet group name"
  value       = aws_db_subnet_group.this.name
}

output "subnet_group_arn" {
  description = "The ARN of the db subnet group"
  value       = aws_db_subnet_group.this.arn
}

output "parameter_group_name" {
  description = "The db parameter group name"
  value       = aws_db_parameter_group.this.name
}

output "parameter_group_arn" {
  description = "The ARN of the db parameter group"
  value       = aws_db_parameter_group.this.arn
}

output "performance_insights_enabled" {
  description = "Whether Performance Insights is enabled"
  value       = aws_db_instance.this.performance_insights_enabled
}

output "cloudwatch_log_groups" {
  description = "Map of CloudWatch log group names"
  value = {
    postgresql = "postgresql"
    upgrade    = "upgrade"
  }
}

output "engine_version_actual" {
  description = "The running version of the database engine"
  value       = aws_db_instance.this.engine_version_actual
}

output "vpc_id" {
  description = "The VPC ID where the RDS instance is deployed"
  value       = data.aws_vpc.selected.id
}
