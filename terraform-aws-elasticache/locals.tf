locals {
  # Extract major version for parameter group family
  engine_major_version = split(".", var.engine_version)[0]

  # Redis and Valkey both use the same port
  port = 6379

  # Determine parameter group family based on engine
  parameter_group_family = var.engine == "redis" ? "redis${local.engine_major_version}" : "valkey${local.engine_major_version}"
  parameter_group_name   = local.cluster_mode_enabled ? "default.${local.parameter_group_family}.cluster.on" : "default.${local.parameter_group_family}"

  # Resource naming with defaults
  replication_group_id          = var.replication_group_id != null ? var.replication_group_id : var.identifier
  replication_group_description = var.description != null ? var.description : "${var.engine} cache cluster for ${var.identifier}"
  subnet_group_name             = var.subnet_group_name != null ? var.subnet_group_name : "${var.identifier}-subnet-group"
  security_group_name           = var.security_group_name != null ? var.security_group_name : "${var.identifier}-sg"

  # Determine if using cluster mode
  cluster_mode_enabled = var.num_node_groups > 1 || var.replicas_per_node_group > 0
}
