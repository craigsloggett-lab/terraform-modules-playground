# Required Variables

variable "identifier" {
  description = "Identifier for the ALB resources. Used to generate resource names if not explicitly provided."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]*$", var.identifier)) && length(var.identifier) <= 32
    error_message = "Identifier must start with a letter, contain only alphanumeric characters and hyphens, and be 32 characters or less."
  }
}

variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be deployed."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ALB. Should be public subnets across multiple AZs."
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least 2 subnets in different Availability Zones are required for high availability."
  }
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate for the HTTPS listener."
  type        = string

  validation {
    condition     = can(regex("^arn:[^:]+:acm:[^:]+:[^:]+:certificate/[a-f0-9-]+$", var.certificate_arn))
    error_message = "Certificate ARN must be a valid ACM certificate ARN."
  }
}

# Optional Variables - ALB Configuration

variable "internal" {
  description = "Whether the load balancer is internal (private) or internet-facing (public)."
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for the ALB. Recommended for production."
  type        = bool
  default     = true
}

variable "enable_http2" {
  description = "Enable HTTP/2 for the ALB."
  type        = bool
  default     = true
}

variable "enable_cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing."
  type        = bool
  default     = true
}

variable "drop_invalid_header_fields" {
  description = "Drop invalid HTTP header fields. Recommended for security."
  type        = bool
  default     = true
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  type        = number
  default     = 60

  validation {
    condition     = var.idle_timeout >= 1 && var.idle_timeout <= 4000
    error_message = "Idle timeout must be between 1 and 4000 seconds."
  }
}

variable "ip_address_type" {
  description = "The type of IP addresses used by the subnets for the load balancer. Valid values are ipv4 or dualstack."
  type        = string
  default     = "ipv4"

  validation {
    condition     = contains(["ipv4", "dualstack"], var.ip_address_type)
    error_message = "IP address type must be ipv4 or dualstack."
  }
}

# Optional Variables - Listener Configuration

variable "listener_port" {
  description = "The port on which the load balancer is listening."
  type        = number
  default     = 443

  validation {
    condition     = var.listener_port >= 1 && var.listener_port <= 65535
    error_message = "Listener port must be between 1 and 65535."
  }
}

variable "listener_protocol" {
  description = "The protocol for connections from clients to the load balancer."
  type        = string
  default     = "HTTPS"

  validation {
    condition     = contains(["HTTP", "HTTPS"], var.listener_protocol)
    error_message = "Listener protocol must be HTTP or HTTPS."
  }
}

variable "ssl_policy" {
  description = "The name of the SSL policy for HTTPS listeners. See AWS documentation for available policies."
  type        = string
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"

  validation {
    condition     = var.listener_protocol != "HTTPS" || can(regex("^ELBSecurityPolicy-", var.ssl_policy))
    error_message = "SSL policy must start with 'ELBSecurityPolicy-'."
  }
}

# Optional Variables - Target Group Configuration

variable "target_group_port" {
  description = "The port on which targets receive traffic."
  type        = number
  default     = 443

  validation {
    condition     = var.target_group_port >= 1 && var.target_group_port <= 65535
    error_message = "Target group port must be between 1 and 65535."
  }
}

variable "target_group_protocol" {
  description = "The protocol to use for routing traffic to the targets."
  type        = string
  default     = "HTTPS"

  validation {
    condition     = contains(["HTTP", "HTTPS"], var.target_group_protocol)
    error_message = "Target group protocol must be HTTP or HTTPS."
  }
}

variable "target_type" {
  description = "The type of target. Valid values are instance, ip, or lambda."
  type        = string
  default     = "instance"

  validation {
    condition     = contains(["instance", "ip", "lambda"], var.target_type)
    error_message = "Target type must be instance, ip, or lambda."
  }
}

variable "deregistration_delay" {
  description = "The amount of time for the load balancer to wait before deregistering a target."
  type        = number
  default     = 300

  validation {
    condition     = var.deregistration_delay >= 0 && var.deregistration_delay <= 3600
    error_message = "Deregistration delay must be between 0 and 3600 seconds."
  }
}

variable "slow_start" {
  description = "The amount of time for targets to warm up before receiving their full share of requests. Set to 0 to disable."
  type        = number
  default     = 0

  validation {
    condition     = var.slow_start >= 0 && var.slow_start <= 900
    error_message = "Slow start must be between 0 and 900 seconds."
  }
}

# Optional Variables - Health Check Configuration

variable "health_check_enabled" {
  description = "Enable health checks for the target group."
  type        = bool
  default     = true
}

variable "health_check_protocol" {
  description = "The protocol to use for health checks."
  type        = string
  default     = "HTTPS"

  validation {
    condition     = contains(["HTTP", "HTTPS"], var.health_check_protocol)
    error_message = "Health check protocol must be HTTP or HTTPS."
  }
}

variable "health_check_path" {
  description = "The destination for health checks on the targets."
  type        = string
  default     = "/"

  validation {
    condition     = can(regex("^/.*$", var.health_check_path))
    error_message = "Health check path must start with '/'."
  }
}

variable "health_check_port" {
  description = "The port to use for health checks. Use 'traffic-port' to use the same port as the target group."
  type        = string
  default     = "traffic-port"
}

variable "health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target."
  type        = number
  default     = 30

  validation {
    condition     = var.health_check_interval >= 5 && var.health_check_interval <= 300
    error_message = "Health check interval must be between 5 and 300 seconds."
  }
}

variable "health_check_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check."
  type        = number
  default     = 5

  validation {
    condition     = var.health_check_timeout >= 2 && var.health_check_timeout <= 120
    error_message = "Health check timeout must be between 2 and 120 seconds."
  }
}

variable "health_check_healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy."
  type        = number
  default     = 2

  validation {
    condition     = var.health_check_healthy_threshold >= 2 && var.health_check_healthy_threshold <= 10
    error_message = "Healthy threshold must be between 2 and 10."
  }
}

variable "health_check_unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering a target unhealthy."
  type        = number
  default     = 10

  validation {
    condition     = var.health_check_unhealthy_threshold >= 2 && var.health_check_unhealthy_threshold <= 10
    error_message = "Unhealthy threshold must be between 2 and 10."
  }
}

variable "health_check_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target."
  type        = string
  default     = "200"

  validation {
    condition     = can(regex("^[0-9,-]+$", var.health_check_matcher))
    error_message = "Health check matcher must be HTTP status codes (e.g., '200' or '200-299')."
  }
}

# Optional Variables - Security

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the ALB. Typically ['0.0.0.0/0'] for internet-facing ALBs."
  type        = list(string)
  default     = ["0.0.0.0/0"]

  validation {
    condition     = alltrue([for cidr in var.allowed_cidr_blocks : can(cidrhost(cidr, 0))])
    error_message = "All elements must be valid CIDR blocks."
  }
}

variable "allowed_security_group_ids" {
  description = "List of security group IDs allowed to access the ALB."
  type        = list(string)
  default     = []
}

# Optional Variables - Naming

variable "alb_name" {
  description = "Name of the Application Load Balancer. If not provided, defaults to identifier."
  type        = string
  default     = null

  validation {
    condition     = var.alb_name == null || (can(regex("^[a-zA-Z][a-zA-Z0-9-]*$", var.alb_name)) && length(var.alb_name) <= 32)
    error_message = "ALB name must start with a letter, contain only alphanumeric characters and hyphens, and be 32 characters or less."
  }
}

variable "target_group_name" {
  description = "Name of the target group. If not provided, defaults to '{identifier}-tg'."
  type        = string
  default     = null

  validation {
    condition     = var.target_group_name == null || (can(regex("^[a-zA-Z][a-zA-Z0-9-]*$", var.target_group_name)) && length(var.target_group_name) <= 32)
    error_message = "Target group name must start with a letter, contain only alphanumeric characters and hyphens, and be 32 characters or less."
  }
}

variable "security_group_name" {
  description = "Name of the security group. If not provided, defaults to '{identifier}-alb-sg'."
  type        = string
  default     = null
}
