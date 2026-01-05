variable "bucket_name" {
  description = "The name of the S3 bucket. To be globally unique across all AWS accounts, the name will be prefixed with '{account_id}-{region}'."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]*[a-z0-9]$", var.bucket_name))
    error_message = "Bucket name must not start or end with a hyphen and contain only lowercase letters, numbers, and hyphens."
  }

  validation {
    condition     = length(var.bucket_name) <= 35
    error_message = "Bucket name must not exceed 35 characters."
  }

  validation {
    condition     = !can(regex("\\.\\.|\\.\\-|\\-\\.", var.bucket_name))
    error_message = "Bucket name cannot contain consecutive periods, or a period adjacent to a hyphen."
  }
}
