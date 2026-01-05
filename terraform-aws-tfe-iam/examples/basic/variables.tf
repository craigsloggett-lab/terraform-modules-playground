variable "s3_bucket_name" {
  description = "The name of the S3 bucket for TFE"
  type        = string
}

variable "ssm_parameter_prefix" {
  description = "The prefix for SSM parameters"
  type        = string
  default     = "/TFE"
}

variable "rds_secret_arn" {
  description = "The ARN of the RDS master user secret"
  type        = string
}
