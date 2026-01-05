output "role_name" {
  description = "The name of the IAM role"
  value       = module.terraform_aws_tfe_iam.role_name
}

output "role_arn" {
  description = "The ARN of the IAM role"
  value       = module.terraform_aws_tfe_iam.role_arn
}

output "role_id" {
  description = "The ID of the IAM role"
  value       = module.terraform_aws_tfe_iam.role_id
}

output "instance_profile_name" {
  description = "The name of the IAM instance profile"
  value       = module.terraform_aws_tfe_iam.instance_profile_name
}

output "instance_profile_arn" {
  description = "The ARN of the IAM instance profile"
  value       = module.terraform_aws_tfe_iam.instance_profile_arn
}

output "instance_profile_id" {
  description = "The ID of the IAM instance profile"
  value       = module.terraform_aws_tfe_iam.instance_profile_id
}
