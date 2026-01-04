data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_kms_key" "rds" {
  key_id = local.rds_kms_key_id
}

data "aws_kms_key" "secretsmanager" {
  key_id = local.secrets_manager_kms_key_id
}
