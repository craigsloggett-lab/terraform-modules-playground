locals {
  # Extract major version for parameter group family
  engine_major_version = split(".", var.engine_version)[0]

  # Determine parameter group family based on engine
  parameter_group_family = var.engine == "redis" ? "redis${local.engine_major_version}" : "valkey${local.engine_major_version}"

  # Resource naming with defaults
  replication_group_id = var.replication_group_id != null ? var.replication_group_id : var.identifier
  parameter_group_name = var.parameter_group_name != null ? var.parameter_group_name : "${var.identifier}-pg"
  security_group_name  = var.security_group_name != null ? var.security_group_name : "${var.identifier}-sg"
  subnet_group_name    = var.subnet_group_name != null ? var.subnet_group_name : "${var.identifier}-subnet-group"

  # KMS key for encryption
  elasticache_kms_key_id = var.elasticache_kms_key_id != null ? var.elasticache_kms_key_id : "alias/aws/elasticache"

  # Port based on engine (Redis and Valkey both use 6379)
  port = 6379

  # Determine if using cluster mode
  cluster_mode_enabled = var.num_node_groups > 1 || var.replicas_per_node_group > 0
}
