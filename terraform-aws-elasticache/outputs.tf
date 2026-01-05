output "replication_group_id" {
  description = "The ID of the ElastiCache replication group"
  value       = aws_elasticache_replication_group.this.id
}

output "replication_group_arn" {
  description = "The ARN of the ElastiCache replication group"
  value       = aws_elasticache_replication_group.this.arn
}

output "primary_endpoint_address" {
  description = "The address of the primary endpoint (for Redis/Valkey in non-cluster mode)"
  value       = try(aws_elasticache_replication_group.this.primary_endpoint_address, null)
}

output "reader_endpoint_address" {
  description = "The address of the reader endpoint (for Redis/Valkey in non-cluster mode)"
  value       = try(aws_elasticache_replication_group.this.reader_endpoint_address, null)
}

output "configuration_endpoint_address" {
  description = "The address of the configuration endpoint (for cluster mode enabled)"
  value       = try(aws_elasticache_replication_group.this.configuration_endpoint_address, null)
}

output "port" {
  description = "The port number on which the cache accepts connections"
  value       = try(aws_elasticache_replication_group.this.port, null)
}

output "auth_token" {
  description = "The auth token for the cache cluster"
  value       = random_password.auth_token.result
  sensitive   = true
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.elasticache.id
}

output "security_group_arn" {
  description = "The ARN of the security group"
  value       = aws_security_group.elasticache.arn
}

output "subnet_group_name" {
  description = "The name of the cache subnet group"
  value       = aws_elasticache_subnet_group.this.name
}

output "parameter_group_name" {
  description = "The name of the parameter group"
  value       = try(aws_elasticache_replication_group.this.parameter_group_name, null)
}

output "engine" {
  description = "The cache engine (redis or valkey)"
  value       = var.engine
}

output "engine_version_actual" {
  description = "The running version of the cache engine"
  value       = aws_elasticache_replication_group.this.engine_version_actual
}

output "cluster_enabled" {
  description = "Whether cluster mode is enabled"
  value       = local.cluster_mode_enabled
}

output "member_clusters" {
  description = "List of member cluster IDs"
  value       = aws_elasticache_replication_group.this.member_clusters
}

output "vpc_id" {
  description = "The VPC ID where the ElastiCache cluster is deployed"
  value       = data.aws_vpc.selected.id
}
