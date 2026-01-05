output "alb_id" {
  description = "The ID of the load balancer"
  value       = aws_lb.this.id
}

output "alb_arn" {
  description = "The ARN of the load balancer"
  value       = aws_lb.this.arn
}

output "alb_arn_suffix" {
  description = "The ARN suffix for use with CloudWatch Metrics"
  value       = aws_lb.this.arn_suffix
}

output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "The canonical hosted zone ID of the load balancer (for Route53 alias records)"
  value       = aws_lb.this.zone_id
}

output "target_group_id" {
  description = "The ID of the target group"
  value       = aws_lb_target_group.this.id
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.this.arn
}

output "target_group_arn_suffix" {
  description = "The ARN suffix for use with CloudWatch Metrics"
  value       = aws_lb_target_group.this.arn_suffix
}

output "target_group_name" {
  description = "The name of the target group"
  value       = aws_lb_target_group.this.name
}

output "listener_id" {
  description = "The ID of the listener"
  value       = aws_lb_listener.this.id
}

output "listener_arn" {
  description = "The ARN of the listener"
  value       = aws_lb_listener.this.arn
}

output "security_group_id" {
  description = "The ID of the ALB security group"
  value       = aws_security_group.alb.id
}

output "security_group_arn" {
  description = "The ARN of the ALB security group"
  value       = aws_security_group.alb.arn
}

output "vpc_id" {
  description = "The VPC ID where the ALB is deployed"
  value       = data.aws_vpc.selected.id
}
