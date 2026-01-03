output "aws_caller_identity" {
  description = "The AWS caller identity data source."
  value       = module.terraform_aws_tfe_iam.aws_caller_identity
}

output "aws_region" {
  description = "The AWS region (current) data source."
  value       = module.terraform_aws_tfe_iam.aws_region
}

output "aws_availability_zones" {
  description = "The AWS availability zones (available) data source."
  value       = module.terraform_aws_tfe_iam.aws_availability_zones
}
