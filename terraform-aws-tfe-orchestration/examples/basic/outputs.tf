output "tfe_url" {
  description = "The URL to access Terraform Enterprise"
  value       = module.tfe.tfe_url
}

output "tfe_hostname" {
  description = "The hostname of TFE"
  value       = module.tfe.tfe_hostname
}

output "database_endpoint" {
  description = "The database connection endpoint"
  value       = module.tfe.database_endpoint
}

output "s3_bucket_name" {
  description = "The S3 bucket name"
  value       = module.tfe.s3_bucket_name
}

output "alb_dns_name" {
  description = "The ALB DNS name"
  value       = module.tfe.alb_dns_name
}
