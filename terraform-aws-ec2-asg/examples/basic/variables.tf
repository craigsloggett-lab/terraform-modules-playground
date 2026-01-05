variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "iam_instance_profile_arn" {
  description = "The ARN of the IAM instance profile"
  type        = string
}

variable "target_group_arn" {
  description = "The ARN of the ALB target group"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for instance access"
  type        = string
}
