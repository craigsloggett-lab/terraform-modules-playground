data "aws_vpc" "elasticache" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.elasticache.id]
  }

  filter {
    name   = "tag:Name"
    values = ["*private-data*"]
  }
}

module "terraform_aws_elasticache" {
  source = "../../"

  identifier = "tfe-cache-001"
  vpc_id     = data.aws_vpc.elasticache.id
  subnet_ids = data.aws_subnets.private.ids

  engine         = "valkey"
  engine_version = "7.2"

  num_cache_clusters         = 2
  automatic_failover_enabled = true
  multi_az_enabled           = true

  allowed_cidr_blocks = [data.aws_vpc.elasticache.cidr_block]

  snapshot_retention_limit = 7
}
