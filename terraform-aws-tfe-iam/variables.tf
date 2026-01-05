variable "identifier" {
  description = "Identifier for the IAM resources. Used to generate role and instance profile names if not explicitly provided."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]*$", var.identifier))
    error_message = "Identifier must start with a letter and contain only alphanumeric characters and hyphens."
  }
}

variable "role_name" {
  description = "Name of the IAM role. If not provided, defaults to '{identifier}-role'."
  type        = string
  default     = null

  validation {
    condition     = var.role_name == null || can(regex("^[a-zA-Z][a-zA-Z0-9-_]*$", var.role_name))
    error_message = "Role name must start with a letter and contain only alphanumeric characters, hyphens, and underscores."
  }
}

variable "instance_profile_name" {
  description = "Name of the IAM instance profile. If not provided, defaults to '{identifier}-instance-profile'."
  type        = string
  default     = null

  validation {
    condition     = var.instance_profile_name == null || can(regex("^[a-zA-Z][a-zA-Z0-9-_]*$", var.instance_profile_name))
    error_message = "Instance profile name must start with a letter and contain only alphanumeric characters, hyphens, and underscores."
  }
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket that TFE will use for object storage."
  type        = string
  default     = null
}

variable "ssm_parameter_arns" {
  description = "List of SSM parameter ARNs that TFE needs read/write access to."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for arn in var.ssm_parameter_arns : can(regex("^arn:[^:]+:ssm:[^:]+:[^:]+:parameter/.*$", arn))])
    error_message = "All SSM parameter ARNs must be valid ARN format."
  }
}

variable "secrets_manager_secret_arns" {
  description = "List of Secrets Manager secret ARNs that TFE needs read access to (e.g., RDS master password secret)."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for arn in var.secrets_manager_secret_arns : can(regex("^arn:[^:]+:secretsmanager:[^:]+:[^:]+:secret:.*$", arn))])
    error_message = "All Secrets Manager secret ARNs must be valid ARN format."
  }
}
