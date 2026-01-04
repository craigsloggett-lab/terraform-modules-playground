variable "vpc_name" {
  description = "The name of the VPC (as defined in the Name tag) where the RDS instance will be deployed."
  type        = string
}

variable "database_subnet_ids" {
  description = "List of subnet IDs for the database subnet group."
  type        = list(string)

  validation {
    condition     = length(var.database_subnet_ids) >= 2
    error_message = "At least 2 subnets in different Availability Zones are required for Multi-AZ deployment."
  }
}
