output "launch_template_id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.this.id
}

output "launch_template_arn" {
  description = "The ARN of the launch template"
  value       = aws_launch_template.this.arn
}

output "launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = aws_launch_template.this.latest_version
}

output "launch_template_default_version" {
  description = "The default version of the launch template"
  value       = aws_launch_template.this.default_version
}

output "autoscaling_group_id" {
  description = "The ID of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.id
}

output "autoscaling_group_arn" {
  description = "The ARN of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.arn
}

output "autoscaling_group_name" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.name
}

output "autoscaling_group_min_size" {
  description = "The minimum size of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.min_size
}

output "autoscaling_group_max_size" {
  description = "The maximum size of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.max_size
}

output "autoscaling_group_desired_capacity" {
  description = "The desired capacity of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.desired_capacity
}

output "security_group_id" {
  description = "The ID of the instance security group"
  value       = aws_security_group.instances.id
}

output "security_group_arn" {
  description = "The ARN of the instance security group"
  value       = aws_security_group.instances.arn
}

output "vpc_id" {
  description = "The VPC ID where instances are deployed"
  value       = data.aws_vpc.selected.id
}
