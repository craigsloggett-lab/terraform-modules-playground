locals {
  account_id  = data.aws_caller_identity.current.account_id
  region      = data.aws_region.current.region
  bucket_name = "${local.account_id}-${local.region}-${var.bucket_name}"
}
