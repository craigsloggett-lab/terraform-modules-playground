output "role_name" {
  description = "The name of the IAM role"
  value       = aws_iam_role.tfe.name
}

output "role_arn" {
  description = "The ARN of the IAM role"
  value       = aws_iam_role.tfe.arn
}

output "role_id" {
  description = "The ID of the IAM role"
  value       = aws_iam_role.tfe.id
}

output "instance_profile_name" {
  description = "The name of the IAM instance profile"
  value       = aws_iam_instance_profile.tfe.name
}

output "instance_profile_arn" {
  description = "The ARN of the IAM instance profile"
  value       = aws_iam_instance_profile.tfe.arn
}

output "instance_profile_id" {
  description = "The ID of the IAM instance profile"
  value       = aws_iam_instance_profile.tfe.id
}
