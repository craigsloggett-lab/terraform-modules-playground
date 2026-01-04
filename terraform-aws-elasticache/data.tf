data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_kms_key" "elasticache" {
  key_id = local.elasticache_kms_key_id
}
