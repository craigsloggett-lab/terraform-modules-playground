output "replication_group_id" {
  description = "The ID of the ElastiCache replication group"
  value       = module.terraform_aws_elasticache.replication_group_id
}

output "replication_group_arn" {
  description = "The ARN of the ElastiCache replication group"
  value       = module.terraform_aws_elasticache.replication_group_arn
}

output "primary_endpoint_address" {
  description = "The address of the primary endpoint"
  value       = module.terraform_aws_elasticache.primary_endpoint_address
}

output "reader_endpoint_address" {
  description = "The address of the reader endpoint"
  value       = module.terraform_aws_elasticache.reader_endpoint_address
}

output "port" {
  description = "The port number on which the cache accepts connections"
  value       = module.terraform_aws_elasticache.port
}

output "auth_token" {
  description = "The auth token for the cache cluster"
  value       = module.terraform_aws_elasticache.auth_token
  sensitive   = true
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.terraform_aws_elasticache.security_group_id
}

output "security_group_arn" {
  description = "The ARN of the security group"
  value       = module.terraform_aws_elasticache.security_group_arn
}

output "subnet_group_name" {
  description = "The name of the cache subnet group"
  value       = module.terraform_aws_elasticache.subnet_group_name
}

output "parameter_group_name" {
  description = "The name of the parameter group"
  value       = module.terraform_aws_elasticache.parameter_group_name
}

output "engine" {
  description = "The cache engine"
  value       = module.terraform_aws_elasticache.engine
}

output "engine_version_actual" {
  description = "The running version of the cache engine"
  value       = module.terraform_aws_elasticache.engine_version_actual
}

output "cluster_enabled" {
  description = "Whether cluster mode is enabled"
  value       = module.terraform_aws_elasticache.cluster_enabled
}

output "member_clusters" {
  description = "List of member cluster IDs"
  value       = module.terraform_aws_elasticache.member_clusters
}

output "vpc_id" {
  description = "The VPC ID where the ElastiCache cluster is deployed"
  value       = module.terraform_aws_elasticache.vpc_id
}
