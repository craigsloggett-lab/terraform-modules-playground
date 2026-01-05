data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_s3_bucket" "tfe" {
  bucket = var.s3_bucket_name
}
