locals {
  # Current AWS context
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name

  # TFE hostname construction
  route53_alias_record_name = var.tfe_subdomain != null ? "${var.tfe_subdomain}.${var.route53_zone_name}" : var.route53_zone_name

  # S3 bucket naming convention: account-region-purpose
  s3_bucket_name = "${local.account_id}-${local.region}-terraform-enterprise"

  # Resource naming prefix
  name_prefix = var.name_prefix
}
