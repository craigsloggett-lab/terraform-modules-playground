output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.terraform_aws_alb.alb_dns_name
}

output "alb_zone_id" {
  description = "The zone ID of the load balancer"
  value       = module.terraform_aws_alb.alb_zone_id
}

output "alb_arn" {
  description = "The ARN of the load balancer"
  value       = module.terraform_aws_alb.alb_arn
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = module.terraform_aws_alb.target_group_arn
}

output "security_group_id" {
  description = "The ID of the ALB security group"
  value       = module.terraform_aws_alb.security_group_id
}
