# Generate auth token if not provided and auth is enabled
resource "random_password" "auth_token" {
  count = var.auth_token_enabled && var.auth_token == null ? 1 : 0

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

# Cache Parameter Group
resource "aws_elasticache_parameter_group" "this" {
  count = length(var.parameters) > 0 ? 1 : 0

  name   = local.parameter_group_name
  family = local.parameter_group_family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  tags = {
    Name = local.parameter_group_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

# ElastiCache Replication Group
resource "aws_elasticache_replication_group" "this" {
  replication_group_id = local.replication_group_id
  description          = var.description != null ? var.description : "${var.engine} cache cluster for ${var.identifier}"

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
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  kms_key_id                 = var.at_rest_encryption_enabled ? data.aws_kms_key.elasticache.arn : null
  transit_encryption_enabled = var.transit_encryption_enabled
  auth_token                 = var.auth_token_enabled ? coalesce(var.auth_token, try(random_password.auth_token[0].result, null)) : null
  auth_token_update_strategy = var.auth_token_enabled ? "ROTATE" : null

  # Backup Configuration
  snapshot_retention_limit = var.snapshot_retention_limit
  snapshot_window          = var.snapshot_window

  # Maintenance
  maintenance_window         = var.maintenance_window
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately          = var.apply_immediately

  # Parameter Group
  parameter_group_name = length(var.parameters) > 0 ? aws_elasticache_parameter_group.this[0].name : null

  # Log Delivery Configuration
  dynamic "log_delivery_configuration" {
    for_each = var.log_delivery_configuration
    content {
      destination      = log_delivery_configuration.value.destination
      destination_type = log_delivery_configuration.value.destination_type
      log_format       = log_delivery_configuration.value.log_format
      log_type         = log_delivery_configuration.value.log_type
    }
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
