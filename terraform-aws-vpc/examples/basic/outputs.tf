output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.terraform_aws_vpc.vpc_id
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = module.terraform_aws_vpc.vpc_arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.terraform_aws_vpc.vpc_cidr_block
}

output "vpc_name" {
  description = "The name of the VPC"
  value       = module.terraform_aws_vpc.vpc_name
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = module.terraform_aws_vpc.public_subnet_ids
}

output "public_subnet_cidrs" {
  description = "List of CIDR blocks of public subnets"
  value       = module.terraform_aws_vpc.public_subnet_cidrs
}

output "private_app_subnet_ids" {
  description = "List of IDs of private application subnets"
  value       = module.terraform_aws_vpc.private_app_subnet_ids
}

output "private_app_subnet_cidrs" {
  description = "List of CIDR blocks of private application subnets"
  value       = module.terraform_aws_vpc.private_app_subnet_cidrs
}

output "private_data_subnet_ids" {
  description = "List of IDs of private data subnets"
  value       = module.terraform_aws_vpc.private_data_subnet_ids
}

output "private_data_subnet_cidrs" {
  description = "List of CIDR blocks of private data subnets"
  value       = module.terraform_aws_vpc.private_data_subnet_cidrs
}

output "database_subnet_group_name" {
  description = "Name of database subnet group (for RDS)"
  value       = module.terraform_aws_vpc.database_subnet_group_name
}

output "availability_zones" {
  description = "List of availability zones used"
  value       = module.terraform_aws_vpc.availability_zones
}

output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = module.terraform_aws_vpc.public_route_table_ids
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = module.terraform_aws_vpc.private_route_table_ids
}

output "database_route_table_ids" {
  description = "List of IDs of database route tables"
  value       = module.terraform_aws_vpc.database_route_table_ids
}

output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"
  value       = module.terraform_aws_vpc.nat_gateway_ids
}

output "nat_public_ips" {
  description = "List of public Elastic IPs created for NAT Gateways"
  value       = module.terraform_aws_vpc.nat_public_ips
}

output "s3_vpc_endpoint_id" {
  description = "ID of the S3 VPC endpoint"
  value       = module.terraform_aws_vpc.s3_vpc_endpoint_id
}

output "dynamodb_vpc_endpoint_id" {
  description = "ID of the DynamoDB VPC endpoint"
  value       = module.terraform_aws_vpc.dynamodb_vpc_endpoint_id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.terraform_aws_vpc.internet_gateway_id
}

output "flow_log_id" {
  description = "ID of the VPC Flow Log"
  value       = module.terraform_aws_vpc.flow_log_id
}

output "flow_log_cloudwatch_iam_role_arn" {
  description = "The ARN of the IAM role used when pushing logs to Cloudwatch log group."
  value       = module.terraform_aws_vpc.flow_log_cloudwatch_iam_role_arn
}

output "region" {
  description = "AWS region where the VPC is created"
  value       = module.terraform_aws_vpc.region
}

output "account_id" {
  description = "AWS account ID where the VPC is created"
  value       = module.terraform_aws_vpc.account_id
}
