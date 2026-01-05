data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "terraform_aws_tfe_iam" {
  source = "../../"

  identifier     = "tfe-001"
  s3_bucket_name = var.s3_bucket_name

  ssm_parameter_arns = [
    "arn:aws:ssm:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:parameter${var.ssm_parameter_prefix}/*"
  ]
  secrets_manager_secret_arns = [
    var.rds_secret_arn
  ]
}
