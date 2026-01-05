output "aws_region" {
  description = "The AWS region (current) data source."
  value       = module.terraform_aws_s3_bucket.aws_region
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket."
  value       = module.terraform_aws_s3_bucket.s3_bucket_name
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket."
  value       = module.terraform_aws_s3_bucket.s3_bucket_arn
}
