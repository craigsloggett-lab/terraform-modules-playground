output "aws_caller_identity" {
  description = "The AWS caller identity data source."
  value       = data.aws_caller_identity.current
}

output "aws_region" {
  description = "The AWS region (current) data source."
  value       = data.aws_region.current
}

output "aws_availability_zones" {
  description = "The AWS availability zones (available) data source."
  value       = data.aws_availability_zones.available
}

output "aws_ami" {
  description = "The details of the AMI image."
  value       = data.aws_ami.debian
}
