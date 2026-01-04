# Required Variables

variable "identifier" {
  description = "The identifier for the ElastiCache replication group. Must be unique within your AWS account in the current region."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]*$", var.identifier)) && length(var.identifier) <= 40
    error_message = "Identifier must start with a letter, contain only lowercase letters, numbers, and hyphens, and be 40 characters or less."
  }
}

variable "vpc_id" {
  description = "The ID of the VPC where the ElastiCache cluster will be deployed."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the cache subnet group. Should be private subnets across multiple AZs for high availability."
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least 2 subnets in different Availability Zones are required for Multi-AZ deployment."
  }
}

# Optional Variables - Engine Configuration

variable "engine" {
  description = "The cache engine to use. Valid values are 'redis' or 'valkey'."
  type        = string
  default     = "valkey"

  validation {
    condition     = contains(["redis", "valkey"], var.engine)
    error_message = "Engine must be either 'redis' or 'valkey'."
  }
}

variable "engine_version" {
  description = "The version of the cache engine. For Redis: 7.x. For Valkey: 7.2 or higher."
  type        = string
  default     = "7.2"

  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+$", var.engine_version))
    error_message = "Engine version must be in format 'major.minor' (e.g., '7.2')."
  }
}

variable "node_type" {
  description = "The instance class for the cache nodes."
  type        = string
  default     = "cache.t3.medium"
}

variable "num_cache_clusters" {
  description = "Number of cache clusters (primary and replicas). Must be at least 2 for automatic failover. Ignored if cluster mode is enabled."
  type        = number
  default     = 2

  validation {
    condition     = var.num_cache_clusters >= 2 && var.num_cache_clusters <= 6
    error_message = "Number of cache clusters must be between 2 and 6 for automatic failover."
  }
}

# Cluster Mode Configuration

variable "num_node_groups" {
  description = "Number of node groups (shards) for cluster mode. Set to 1 to disable cluster mode."
  type        = number
  default     = 1

  validation {
    condition     = var.num_node_groups >= 1 && var.num_node_groups <= 500
    error_message = "Number of node groups must be between 1 and 500."
  }
}

variable "replicas_per_node_group" {
  description = "Number of replica nodes per node group (shard). Only used when cluster mode is enabled."
  type        = number
  default     = 0

  validation {
    condition     = var.replicas_per_node_group >= 0 && var.replicas_per_node_group <= 5
    error_message = "Replicas per node group must be between 0 and 5."
  }
}

# High Availability

variable "automatic_failover_enabled" {
  description = "Enable automatic failover for the replication group. Required when num_cache_clusters > 1 or cluster mode is enabled."
  type        = bool
  default     = true
}

variable "multi_az_enabled" {
  description = "Enable Multi-AZ for automatic failover. Requires automatic_failover_enabled to be true."
  type        = bool
  default     = true
}

# Security

variable "at_rest_encryption_enabled" {
  description = "Enable encryption at rest. Cannot be disabled for compliance."
  type        = bool
  default     = true

  validation {
    condition     = var.at_rest_encryption_enabled == true
    error_message = "Encryption at rest is required for compliance and cannot be disabled."
  }
}

variable "transit_encryption_enabled" {
  description = "Enable encryption in transit (TLS). Cannot be disabled for compliance."
  type        = bool
  default     = true

  validation {
    condition     = var.transit_encryption_enabled == true
    error_message = "Encryption in transit is required for compliance and cannot be disabled."
  }
}

variable "auth_token_enabled" {
  description = "Enable Redis AUTH token for authentication. Recommended for production."
  type        = bool
  default     = true
}

variable "auth_token" {
  description = "The password used to access the cache. Required if auth_token_enabled is true. If not provided, one will be generated. Must be 16-128 characters."
  type        = string
  default     = null
  sensitive   = true

  validation {
    condition     = var.auth_token == null || (length(var.auth_token) >= 16 && length(var.auth_token) <= 128)
    error_message = "Auth token must be between 16 and 128 characters if provided."
  }
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the cache. Should typically be your VPC CIDR or application subnet CIDRs."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for cidr in var.allowed_cidr_blocks : can(cidrhost(cidr, 0))])
    error_message = "All elements must be valid CIDR blocks."
  }
}

variable "allowed_security_group_ids" {
  description = "List of security group IDs allowed to access the cache (e.g., application server security groups)."
  type        = list(string)
  default     = []
}

variable "elasticache_kms_key_id" {
  description = "The ARN of the KMS key for encryption at rest. If not specified, uses the default aws/elasticache key."
  type        = string
  default     = null
}

# Backup and Maintenance

variable "snapshot_retention_limit" {
  description = "Number of days to retain automatic snapshots. Set to 0 to disable automated backups."
  type        = number
  default     = 7

  validation {
    condition     = var.snapshot_retention_limit >= 0 && var.snapshot_retention_limit <= 35
    error_message = "Snapshot retention limit must be between 0 and 35 days."
  }
}

variable "snapshot_window" {
  description = "The daily time range during which automated backups are created (e.g., '03:00-05:00'). Must not overlap with maintenance_window."
  type        = string
  default     = "03:00-05:00"
}

variable "maintenance_window" {
  description = "The weekly time range for maintenance (e.g., 'sun:05:00-sun:06:00'). Must not overlap with snapshot_window."
  type        = string
  default     = "sun:05:00-sun:06:00"
}

variable "auto_minor_version_upgrade" {
  description = "Enable automatic minor version upgrades during the maintenance window."
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Apply changes immediately instead of during the next maintenance window."
  type        = bool
  default     = false
}

# Monitoring and Logging

variable "log_delivery_configuration" {
  description = "Log delivery configuration for slow-log and engine-log."
  type = list(object({
    destination      = string
    destination_type = string
    log_format       = string
    log_type         = string
  }))
  default = []
}

variable "cloudwatch_logs_retention_days" {
  description = "The number of days to retain CloudWatch logs. Only used if log delivery is configured."
  type        = number
  default     = 30

  validation {
    condition     = contains([1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653], var.cloudwatch_logs_retention_days)
    error_message = "CloudWatch logs retention must be one of the valid values."
  }
}

# Parameter Group

variable "parameter_group_name" {
  description = "Name of the parameter group. If not provided, defaults to '{identifier}-pg'."
  type        = string
  default     = null
}

variable "parameters" {
  description = "List of parameters to apply to the cache cluster."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

# Naming

variable "replication_group_id" {
  description = "The replication group identifier. If not provided, uses the identifier variable."
  type        = string
  default     = null
}

variable "description" {
  description = "Description for the replication group."
  type        = string
  default     = null
}

variable "subnet_group_name" {
  description = "Name of the cache subnet group. If not provided, defaults to '{identifier}-subnet-group'."
  type        = string
  default     = null
}

variable "security_group_name" {
  description = "Name of the security group. If not provided, defaults to '{identifier}-sg'."
  type        = string
  default     = null
}
