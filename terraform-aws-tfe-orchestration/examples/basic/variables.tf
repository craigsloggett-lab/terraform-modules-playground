variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "route53_zone_name" {
  description = "The Route53 hosted zone name"
  type        = string
}

variable "tfe_license" {
  description = "The TFE license"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "production"
}
