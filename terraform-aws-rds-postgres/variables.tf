# Required Variables

variable "identifier" {
  description = "The name of the RDS instance. Must be unique within your AWS account in the current region."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]*$", var.identifier)) && length(var.identifier) <= 63
    error_message = "Identifier must start with a letter, contain only lowercase letters, numbers, and hyphens, and be 63 characters or less."
  }
}

variable "vpc_id" {
  description = "The id of the VPC where the RDS instance will be deployed."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the database subnet group. Should be private subnets across multiple AZs for high availability."
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least 2 subnets in different Availability Zones are required for Multi-AZ deployment."
  }
}

variable "database_name" {
  description = "The name of the database to create when the DB instance is created. If not provided, no database is created."
  type        = string
  default     = null

  validation {
    condition     = var.database_name == null || can(regex("^[a-zA-Z][a-zA-Z0-9_]*$", var.database_name))
    error_message = "Database name must begin with a letter and contain only alphanumeric characters and underscores."
  }
}

variable "username" {
  description = "Username for the DB user. Cannot be 'postgres' as it's reserved."
  type        = string
  default     = "dbadmin"

  validation {
    condition     = var.username != "postgres" && can(regex("^[a-zA-Z][a-zA-Z0-9_]*$", var.username))
    error_message = "Username cannot be 'postgres', must begin with a letter, and contain only alphanumeric characters and underscores."
  }
}

# Optional Variables

variable "postgres_version" {
  description = "The version of PostgreSQL to use. Use format 'major.minor' (e.g., '16.4')."
  type        = string
  default     = "18.1"

  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+$", var.postgres_version))
    error_message = "PostgreSQL version must be in format 'major.minor' (e.g., '16.4')."
  }
}

variable "instance_class" {
  description = "The instance type of the RDS instance."
  type        = string
  default     = "db.t3.medium"
}

variable "allocated_storage" {
  description = "The allocated storage in GiB."
  type        = number
  default     = 64

  validation {
    condition     = var.allocated_storage >= 20 && var.allocated_storage <= 65536
    error_message = "Allocated storage must be between 20 and 65,536 GiB."
  }
}

variable "max_allocated_storage" {
  description = "The upper limit in GiB which RDS can automatically scale the storage. Set to 0 to disable storage autoscaling."
  type        = number
  default     = 0

  validation {
    condition     = var.max_allocated_storage == 0 || var.max_allocated_storage >= var.allocated_storage
    error_message = "Max allocated storage must be 0 (disabled) or greater than or equal to allocated_storage."
  }
}

variable "storage_type" {
  description = "The storage type. Can be 'gp2', 'gp3', 'io1', or 'io2'."
  type        = string
  default     = "gp3"

  validation {
    condition     = contains(["gp2", "gp3", "io1", "io2"], var.storage_type)
    error_message = "Storage type must be one of: gp2, gp3, io1, io2."
  }
}

variable "iops" {
  description = "The amount of provisioned IOPS. Required for io1 and io2 storage types."
  type        = number
  default     = null
}

variable "storage_throughput" {
  description = "The storage throughput value for gp3 storage type (MiB/s)."
  type        = number
  default     = null
}

variable "backup_retention_period" {
  description = "The days to retain backups. Must be between 1 and 35. Set to 0 to disable automated backups (not recommended)."
  type        = number
  default     = 7

  validation {
    condition     = var.backup_retention_period >= 0 && var.backup_retention_period <= 35
    error_message = "Backup retention period must be between 0 and 35 days."
  }
}

variable "backup_window" {
  description = "The daily time range during which automated backups are created (e.g., '03:00-04:00'). Must not overlap with maintenance_window."
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "The window to perform maintenance (e.g., 'Mon:04:00-Mon:05:00'). Must not overlap with backup_window."
  type        = string
  default     = "Mon:04:00-Mon:05:00"
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically during the maintenance window."
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "If true, the database cannot be deleted. Recommended for production databases."
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before deletion. Set to false for production."
  type        = bool
  default     = false
}

variable "copy_tags_to_snapshot" {
  description = "Copy all instance tags to snapshots."
  type        = bool
  default     = true
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the database. Should typically be your VPC CIDR or application subnet CIDRs."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for cidr in var.allowed_cidr_blocks : can(cidrhost(cidr, 0))])
    error_message = "All elements must be valid CIDR blocks."
  }
}

variable "allowed_security_group_ids" {
  description = "List of security group IDs allowed to access the database (e.g., application server security groups)."
  type        = list(string)
  default     = []
}

variable "rds_kms_key_id" {
  description = "The ARN for the KMS encryption key for RDS storage and Performance Insights. If not specified, uses the default aws/rds key."
  type        = string
  default     = null
}

variable "secrets_manager_kms_key_id" {
  description = "The ARN for the KMS encryption key for Secrets Manager. If not specified, uses the default aws/secretsmanager key."
  type        = string
  default     = null
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled."
  type        = bool
  default     = true
}

variable "performance_insights_retention_period" {
  description = "The number of days to retain Performance Insights data. Valid values are 7, 31, 62, 93, 124, 155, 186, 217, 248, 279, 310, 341, 372, 403, 434, 465, 496, 527, 558, 589, 620, 651, 682, 713, 731."
  type        = number
  default     = 7

  validation {
    condition     = contains([7, 31, 62, 93, 124, 155, 186, 217, 248, 279, 310, 341, 372, 403, 434, 465, 496, 527, 558, 589, 620, 651, 682, 713, 731], var.performance_insights_retention_period)
    error_message = "Performance Insights retention period must be one of the valid values."
  }
}

variable "cloudwatch_logs_retention_days" {
  description = "The number of days to retain CloudWatch logs."
  type        = number
  default     = 30

  validation {
    condition     = contains([1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653], var.cloudwatch_logs_retention_days)
    error_message = "CloudWatch logs retention must be one of the valid values."
  }
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to create. If not provided, defaults to '{identifier}-pg'."
  type        = string
  default     = null
}

variable "parameters" {
  description = "A list of DB parameters to apply. Use this to customize PostgreSQL configuration."
  type = list(object({
    name  = string
    value = string
  }))
  default = [
    {
      name  = "log_statement"
      value = "all"
    },
    {
      name  = "log_min_duration_statement"
      value = "1000" # Log queries taking longer than 1 second
    }
  ]
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately or during the next maintenance window."
  type        = bool
  default     = false
}

variable "subnet_group_name" {
  description = "Name of the DB subnet group. If not provided, defaults to '{identifier}-subnet-group'."
  type        = string
  default     = null
}

variable "security_group_name" {
  description = "Name of the security group. If not provided, defaults to '{identifier}-sg'."
  type        = string
  default     = null
}
