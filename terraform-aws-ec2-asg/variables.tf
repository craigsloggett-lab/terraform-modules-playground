# Required Variables

variable "identifier" {
  description = "Identifier for the ASG resources. Used to generate resource names if not explicitly provided."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]*$", var.identifier))
    error_message = "Identifier must start with a letter and contain only alphanumeric characters and hyphens."
  }
}

variable "vpc_id" {
  description = "The ID of the VPC where the instances will be deployed."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling Group. Should be private subnets across multiple AZs."
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least 2 subnets in different Availability Zones are required for high availability."
  }
}

variable "ami_id" {
  description = "The AMI ID to use for the launch template."
  type        = string

  validation {
    condition     = can(regex("^ami-[a-f0-9]{8,}$", var.ami_id))
    error_message = "AMI ID must be a valid format (ami-xxxxxxxx)."
  }
}

# Optional Variables - Instance Configuration

variable "instance_type" {
  description = "The instance type to use for the launch template."
  type        = string
  default     = "t3.medium"
}

variable "aws_key_pair_name" {
  description = "The key name to use for SSH access. If not provided, instances will not have SSH access."
  type        = string
  default     = null
}

variable "iam_instance_profile_arn" {
  description = "The ARN of the IAM instance profile to attach to instances."
  type        = string
  default     = null

  validation {
    condition     = var.iam_instance_profile_arn == null || can(regex("^arn:[^:]+:iam::[^:]+:instance-profile/.*$", var.iam_instance_profile_arn))
    error_message = "IAM instance profile ARN must be a valid ARN format."
  }
}

variable "user_data" {
  description = "The user data to provide when launching the instance. Will be base64 encoded automatically."
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "The base64-encoded user data to provide when launching the instance. Use this if you want to provide pre-encoded user data."
  type        = string
  default     = null

  validation {
    condition     = var.user_data == null || var.user_data_base64 == null
    error_message = "Only one of user_data or user_data_base64 can be provided."
  }
}

variable "enable_monitoring" {
  description = "Enable detailed monitoring (1-minute intervals). Incurs additional charges."
  type        = bool
  default     = true
}

variable "ebs_optimized" {
  description = "Enable EBS optimization for the instance."
  type        = bool
  default     = true
}

# Optional Variables - Root Block Device

variable "root_volume_type" {
  description = "The type of root volume. Can be standard, gp2, gp3, io1, io2, sc1, or st1."
  type        = string
  default     = "gp3"

  validation {
    condition     = contains(["standard", "gp2", "gp3", "io1", "io2", "sc1", "st1"], var.root_volume_type)
    error_message = "Root volume type must be one of: standard, gp2, gp3, io1, io2, sc1, st1."
  }
}

variable "root_volume_size" {
  description = "The size of the root volume in GB."
  type        = number
  default     = 50

  validation {
    condition     = var.root_volume_size >= 8 && var.root_volume_size <= 16384
    error_message = "Root volume size must be between 8 and 16384 GB."
  }
}

variable "root_volume_iops" {
  description = "The amount of provisioned IOPS for the root volume. Required for io1, io2, and gp3 volume types."
  type        = number
  default     = 3000

  validation {
    condition     = var.root_volume_iops == null || (var.root_volume_iops >= 100 && var.root_volume_iops <= 64000)
    error_message = "Root volume IOPS must be between 100 and 64000."
  }
}

variable "root_volume_throughput" {
  description = "The throughput for the root volume in MB/s. Only valid for gp3 volumes."
  type        = number
  default     = 125

  validation {
    condition     = var.root_volume_throughput == null || (var.root_volume_throughput >= 125 && var.root_volume_throughput <= 1000)
    error_message = "Root volume throughput must be between 125 and 1000 MB/s."
  }
}

variable "delete_on_termination" {
  description = "Whether the root volume should be destroyed on instance termination."
  type        = bool
  default     = true
}

# Optional Variables - Metadata Options (IMDSv2)

variable "http_endpoint" {
  description = "Enable or disable the HTTP metadata endpoint on instances."
  type        = string
  default     = "enabled"

  validation {
    condition     = contains(["enabled", "disabled"], var.http_endpoint)
    error_message = "HTTP endpoint must be either enabled or disabled."
  }
}

variable "http_tokens" {
  description = "Whether or not the metadata service requires session tokens (IMDSv2). Set to 'required' for IMDSv2."
  type        = string
  default     = "required"

  validation {
    condition     = contains(["optional", "required"], var.http_tokens)
    error_message = "HTTP tokens must be either optional or required."
  }
}

variable "http_put_response_hop_limit" {
  description = "The desired HTTP PUT response hop limit for instance metadata requests."
  type        = number
  default     = 1

  validation {
    condition     = var.http_put_response_hop_limit >= 1 && var.http_put_response_hop_limit <= 64
    error_message = "HTTP PUT response hop limit must be between 1 and 64."
  }
}

# Optional Variables - Auto Scaling Group

variable "min_size" {
  description = "The minimum size of the Auto Scaling Group."
  type        = number
  default     = 2
}

variable "max_size" {
  description = "The maximum size of the Auto Scaling Group."
  type        = number
  default     = 4

  validation {
    condition     = var.max_size >= 1
    error_message = "Maximum size must be 1 or greater."
  }

  validation {
    condition     = var.max_size >= var.min_size
    error_message = "Maximum size must be greater than or equal to minimum size."
  }
}

variable "desired_capacity" {
  description = "The desired capacity of the Auto Scaling Group. If not specified, defaults to min_size."
  type        = number
  default     = null

  validation {
    condition     = var.desired_capacity == null || var.desired_capacity >= 0
    error_message = "Desired capacity must be 0 or greater."
  }
}

variable "health_check_type" {
  description = "The type of health check. Valid values are EC2 or ELB."
  type        = string
  default     = "ELB"

  validation {
    condition     = contains(["EC2", "ELB"], var.health_check_type)
    error_message = "Health check type must be EC2 or ELB."
  }
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health."
  type        = number
  default     = 300

  validation {
    condition     = var.health_check_grace_period >= 0
    error_message = "Health check grace period must be 0 or greater."
  }
}

variable "default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another can begin."
  type        = number
  default     = 300

  validation {
    condition     = var.default_cooldown >= 0
    error_message = "Default cooldown must be 0 or greater."
  }
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the Auto Scaling Group should be terminated."
  type        = list(string)
  default     = ["Default"]

  validation {
    condition = alltrue([
      for policy in var.termination_policies :
      contains(["OldestInstance", "NewestInstance", "OldestLaunchConfiguration", "OldestLaunchTemplate", "ClosestToNextInstanceHour", "Default", "AllocationStrategy"], policy)
    ])
    error_message = "Termination policies must be valid ASG termination policies."
  }
}

variable "enabled_metrics" {
  description = "List of metrics to collect for the Auto Scaling Group."
  type        = list(string)
  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]
}

variable "metrics_granularity" {
  description = "The granularity to associate with the metrics to collect."
  type        = string
  default     = "1Minute"
}

variable "wait_for_capacity_timeout" {
  description = "Maximum duration to wait for all instances to be healthy in the ASG."
  type        = string
  default     = "10m"
}

variable "protect_from_scale_in" {
  description = "Whether newly launched instances are protected from scale in."
  type        = bool
  default     = false
}

# Optional Variables - Target Group Integration

variable "target_group_arns" {
  description = "List of target group ARNs to attach to the Auto Scaling Group."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for arn in var.target_group_arns : can(regex("^arn:[^:]+:elasticloadbalancing:[^:]+:[^:]+:targetgroup/.*$", arn))])
    error_message = "All target group ARNs must be valid ARN format."
  }
}

variable "ingress_rules" {
  description = "List of ingress rules for the security group."
  type = list(object({
    description = string
    cidr_ipv4   = string
    ip_protocol = string
    from_port   = number
    to_port     = number
  }))
  default = []
}

# Optional Variables - Naming

variable "launch_template_name" {
  description = "Name of the launch template. If not provided, defaults to '{identifier}-lt'."
  type        = string
  default     = null
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group. If not provided, defaults to '{identifier}-asg'."
  type        = string
  default     = null
}

variable "security_group_name" {
  description = "Name of the security group. If not provided, defaults to '{identifier}-sg'."
  type        = string
  default     = null
}
