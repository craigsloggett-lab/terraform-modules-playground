output "launch_template_id" {
  description = "The ID of the launch template"
  value       = module.terraform_aws_ec2_asg.launch_template_id
}

output "autoscaling_group_name" {
  description = "The name of the Auto Scaling Group"
  value       = module.terraform_aws_ec2_asg.autoscaling_group_name
}

output "autoscaling_group_arn" {
  description = "The ARN of the Auto Scaling Group"
  value       = module.terraform_aws_ec2_asg.autoscaling_group_arn
}

output "security_group_id" {
  description = "The ID of the instance security group"
  value       = module.terraform_aws_ec2_asg.security_group_id
}
