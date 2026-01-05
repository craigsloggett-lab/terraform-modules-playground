# Generate auth token if not provided and auth is enabled
resource "random_password" "auth_token" {
  length  = 32
  special = true
  # ElastiCache auth token has specific character requirements
  override_special = "!&#$^<>-"
}

# Cache Subnet Group
resource "aws_elasticache_subnet_group" "this" {
  name       = local.subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = local.subnet_group_name
  }
}

# ElastiCache Replication Group
resource "aws_elasticache_replication_group" "this" {
  replication_group_id = local.replication_group_id
  description          = local.replication_group_description

  # Engine Configuration
  engine         = var.engine
  engine_version = var.engine_version
  node_type      = var.node_type
  port           = local.port

  # Cluster Configuration
  num_cache_clusters         = local.cluster_mode_enabled ? null : var.num_cache_clusters
  num_node_groups            = local.cluster_mode_enabled ? var.num_node_groups : null
  replicas_per_node_group    = local.cluster_mode_enabled ? var.replicas_per_node_group : null
  automatic_failover_enabled = var.automatic_failover_enabled
  multi_az_enabled           = var.multi_az_enabled

  # Network Configuration
  subnet_group_name  = aws_elasticache_subnet_group.this.name
  security_group_ids = [aws_security_group.elasticache.id]

  # Security
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  auth_token                 = random_password.auth_token.result
  auth_token_update_strategy = "SET"

  # Backup Configuration
  snapshot_retention_limit = var.snapshot_retention_limit
  snapshot_window          = var.snapshot_window

  # Maintenance
  maintenance_window         = var.maintenance_window
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately          = var.apply_immediately

  # Parameter Group
  parameter_group_name = local.parameter_group_name

  # Log Delivery Configuration
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.slow_log.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.engine_log.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "engine-log"
  }

  tags = {
    Name = var.identifier
  }

  # Ensure log groups exist before ElastiCache starts logging
  depends_on = [
    aws_cloudwatch_log_group.slow_log,
    aws_cloudwatch_log_group.engine_log
  ]
}
