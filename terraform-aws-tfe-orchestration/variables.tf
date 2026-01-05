variable "name_prefix" {
  description = "Prefix for resource names (e.g., 'tfe' or 'tfe-prod'). Used to generate consistent names across all resources."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]*$", var.name_prefix)) && length(var.name_prefix) <= 20
    error_message = "Name prefix must start with a letter, contain only lowercase letters, numbers, and hyphens, and be 20 characters or less."
  }
}

variable "route53_zone_name" {
  description = "The Route53 hosted zone name for TFE (e.g., 'example.com'). Must be an existing hosted zone."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]*[a-z0-9]$", var.route53_zone_name))
    error_message = "Route53 zone name must be a valid domain name."
  }
}

variable "tfe_subdomain" {
  description = "The subdomain for TFE (e.g., 'tfe'). If null, uses the root domain. Final hostname will be subdomain.zone_name or just zone_name."
  type        = string
  default     = "tfe"

  validation {
    condition     = var.tfe_subdomain == null || can(regex("^[a-z0-9][a-z0-9-]*$", var.tfe_subdomain))
    error_message = "TFE subdomain must start with a letter or number and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "vpc_id" {
  description = "The ID of an existing VPC to deploy TFE into. If not provided, creates a new VPC."
  type        = string
  default     = null
}

variable "public_subnet_ids" {
  description = "List of existing public subnet IDs for the ALB. If not provided, searches for subnets named *public* in the VPC."
  type        = list(string)
  default     = null
}

variable "private_app_subnet_ids" {
  description = "List of existing private app subnet IDs for EC2 instances. If not provided, searches for subnets named *private-app* in the VPC."
  type        = list(string)
  default     = null
}

variable "private_data_subnet_ids" {
  description = "List of existing private data subnet IDs for RDS/ElastiCache. If not provided, searches for subnets named *private-data* in the VPC."
  type        = list(string)
  default     = null
}

variable "tfe_license" {
  description = "The TFE license string."
  type        = string
  sensitive   = true
}

variable "tfe_version" {
  description = "The version of TFE to deploy (e.g., 'v202501-1')."
  type        = string
  default     = "1.1.2"
}

variable "database_name" {
  description = "The name of the PostgreSQL database."
  type        = string
  default     = "tfe"
}

variable "database_username" {
  description = "The username for the PostgreSQL database."
  type        = string
  default     = "tfeadmin"
}

variable "database_instance_class" {
  description = "The instance class for the RDS PostgreSQL database."
  type        = string
  default     = "db.t3.medium"
}

variable "database_allocated_storage" {
  description = "The allocated storage in GB for the RDS database."
  type        = number
  default     = 64
}

variable "cache_engine" {
  description = "The cache engine to use (redis or valkey)."
  type        = string
  default     = "valkey"

  validation {
    condition     = contains(["redis", "valkey"], var.cache_engine)
    error_message = "Cache engine must be either 'redis' or 'valkey'."
  }
}

variable "cache_node_type" {
  description = "The instance class for the ElastiCache nodes."
  type        = string
  default     = "cache.t3.medium"
}

variable "instance_type" {
  description = "The EC2 instance type for TFE application servers."
  type        = string
  default     = "t3.large"
}

variable "instance_ami_id" {
  description = "The AMI ID for TFE instances. If not provided, uses latest Debian 12."
  type        = string
  default     = null
}

variable "asg_min_size" {
  description = "Minimum number of TFE instances in the Auto Scaling Group."
  type        = number
  default     = 2

  validation {
    condition     = var.asg_min_size >= 2
    error_message = "Minimum ASG size must be at least 2 for high availability."
  }
}

variable "asg_max_size" {
  description = "Maximum number of TFE instances in the Auto Scaling Group."
  type        = number
  default     = 4

  validation {
    condition     = var.asg_max_size >= var.asg_min_size
    error_message = "Maximum ASG size must be greater than or equal to minimum size."
  }
}

variable "asg_desired_capacity" {
  description = "Desired number of TFE instances in the Auto Scaling Group. If not specified, defaults to min_size."
  type        = number
  default     = null
}

variable "ssh_key_name" {
  description = "The name of an existing EC2 key pair for SSH access to instances. If not provided, instances won't have SSH access."
  type        = string
  default     = null
}

variable "user_data_script" {
  description = "Custom user data script for TFE instances. If not provided, uses a default startup script."
  type        = string
  default     = null
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access TFE via the ALB. Use ['0.0.0.0/0'] for public access."
  type        = list(string)
  default     = ["0.0.0.0/0"]

  validation {
    condition     = alltrue([for cidr in var.allowed_cidr_blocks : can(cidrhost(cidr, 0))])
    error_message = "All elements must be valid CIDR blocks."
  }
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for RDS and ALB. Set to false for non-production environments."
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Skip final RDS snapshot on deletion. Set to true for non-production environments."
  type        = bool
  default     = false
}

variable "force_destroy_s3" {
  description = "Allow deletion of non-empty S3 bucket. Set to true only for non-production environments."
  type        = bool
  default     = false
}
