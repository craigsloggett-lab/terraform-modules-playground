# Required Variables

variable "vpc_name" {
  description = "The name of the VPC. This will be used in the Name tag and subnet naming."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]*$", var.vpc_name))
    error_message = "VPC name must start with a letter, contain only lowercase letters, numbers, and hyphens."
  }
}

# Optional Variables

variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Must be /16 for automatic subnet calculation. Choose a CIDR that does not overlap with other VPCs you may peer with or on-premises networks."
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "VPC CIDR must be a valid IPv4 CIDR block."
  }

  validation {
    condition     = tonumber(split("/", var.vpc_cidr)[1]) == 16
    error_message = "VPC CIDR must be exactly /16 for automatic subnet calculation."
  }

  validation {
    condition = (
      can(cidrsubnet(var.vpc_cidr, 0, 0)) &&
      (
        # RFC 1918 private address space
        # 10.0.0.0/8: matches 10.X.0.0/16 where X is 0-255
        can(regex("^10\\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\\.0\\.0/16$", var.vpc_cidr)) ||
        # 172.16.0.0/12: matches 172.X.0.0/16 where X is 16-31
        can(regex("^172\\.(1[6-9]|2[0-9]|3[0-1])\\.0\\.0/16$", var.vpc_cidr)) ||
        # 192.168.0.0/16: matches exactly 192.168.0.0/16
        can(regex("^192\\.168\\.0\\.0/16$", var.vpc_cidr))
      )
    )
    error_message = "VPC CIDR must be within RFC 1918 private address space: 10.0.0.0/8, 172.16.0.0/12, or 192.168.0.0/16."
  }
}

variable "number_of_azs" {
  description = "Number of Availability Zones to use. Must be at least 2 for high availability."
  type        = number
  default     = 3

  validation {
    condition     = var.number_of_azs >= 2 && var.number_of_azs <= 6
    error_message = "Number of AZs must be between 2 and 6 for production workloads."
  }
}

# Subnet Configuration

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets. If not provided, will be calculated automatically from VPC CIDR."
  type        = list(string)
  default     = null

  validation {
    condition     = var.public_subnet_cidrs == null || alltrue([for cidr in var.public_subnet_cidrs : can(cidrhost(cidr, 0))])
    error_message = "All public subnet CIDRs must be valid IPv4 CIDR blocks."
  }
}

variable "private_app_subnet_cidrs" {
  description = "List of CIDR blocks for private application subnets. If not provided, will be calculated automatically from VPC CIDR."
  type        = list(string)
  default     = null

  validation {
    condition     = var.private_app_subnet_cidrs == null || alltrue([for cidr in var.private_app_subnet_cidrs : can(cidrhost(cidr, 0))])
    error_message = "All private app subnet CIDRs must be valid IPv4 CIDR blocks."
  }
}

variable "private_data_subnet_cidrs" {
  description = "List of CIDR blocks for private data subnets (databases, caches). If not provided, will be calculated automatically from VPC CIDR."
  type        = list(string)
  default     = null

  validation {
    condition     = var.private_data_subnet_cidrs == null || alltrue([for cidr in var.private_data_subnet_cidrs : can(cidrhost(cidr, 0))])
    error_message = "All private data subnet CIDRs must be valid IPv4 CIDR blocks."
  }
}

# RDS Subnet Groups

variable "create_database_subnet_groups" {
  description = "Whether to create database subnet groups. Recommended to set this to 'false' and create database subnet groups when creating a database."
  type        = bool
  default     = false
}

# DNS

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC."
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC."
  type        = bool
  default     = true
}

# NAT Gateway Configuration

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnet internet access. Required for private subnets to access the internet."
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use a single NAT Gateway for all private subnets (cost optimization) vs one per AZ (high availability)."
  type        = bool
  default     = false

  validation {
    condition     = var.enable_nat_gateway || var.single_nat_gateway == false
    error_message = "single_nat_gateway can only be set to true when enable_nat_gateway is true. If NAT Gateway is disabled, set single_nat_gateway to false."
  }

  validation {
    condition     = !var.single_nat_gateway || !var.one_nat_gateway_per_az
    error_message = "Cannot set both 'single_nat_gateway' and 'one_nat_gateway_per_az' to true. Choose one NAT Gateway strategy: single (cost-optimized) or per-AZ (highly available)."
  }
}

variable "one_nat_gateway_per_az" {
  description = "Create one NAT Gateway per Availability Zone for high availability."
  type        = bool
  default     = true

  validation {
    condition     = var.enable_nat_gateway || var.one_nat_gateway_per_az == false
    error_message = "one_nat_gateway_per_az can only be set to true when enable_nat_gateway is true. If NAT Gateway is disabled, set one_nat_gateway_per_az to false."
  }
}

# Network ACLs

variable "manage_default_network_acl" {
  description = "Manage the default network ACL. Set to false to leave it unmanaged."
  type        = bool
  default     = true
}

variable "default_network_acl_ingress" {
  description = "List of maps of ingress rules for default network ACL."
  type = list(object({
    rule_no    = number
    action     = string
    from_port  = number
    to_port    = number
    protocol   = string
    cidr_block = string
  }))
  default = [
    {
      rule_no    = 100
      action     = "allow"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    }
  ]
}

variable "default_network_acl_egress" {
  description = "List of maps of egress rules for default network ACL."
  type = list(object({
    rule_no    = number
    action     = string
    from_port  = number
    to_port    = number
    protocol   = string
    cidr_block = string
  }))
  default = [
    {
      rule_no    = 100
      action     = "allow"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    }
  ]
}

# Flow Logs

variable "enable_flow_log" {
  description = "Enable VPC Flow Logs for network traffic analysis and security."
  type        = bool
  default     = true
}

variable "flow_logs_retention_days" {
  description = "Number of days to retain VPC Flow Logs in CloudWatch."
  type        = number
  default     = 30

  validation {
    condition     = contains([1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653], var.flow_logs_retention_days)
    error_message = "Flow logs retention must be one of the valid CloudWatch Logs retention values."
  }
}

variable "flow_logs_traffic_type" {
  description = "The type of traffic to capture in flow logs. Valid values: ACCEPT, REJECT, ALL."
  type        = string
  default     = "ALL"

  validation {
    condition     = contains(["ACCEPT", "REJECT", "ALL"], var.flow_logs_traffic_type)
    error_message = "Flow logs traffic type must be one of: ACCEPT, REJECT, ALL."
  }
}

# Waypoint

variable "waypoint_application" {
  description = "The Waypoint Application name injected during a Waypoint application deployment."
  type        = string
  default     = null
}
