data "aws_vpc" "rds" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.rds.id]
  }

  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
}

module "terraform_aws_rds_postgres" {
  source = "../../"

  identifier = "tfe-postgres-db-001"
  vpc_id     = data.aws_vpc.rds.id
  subnet_ids = data.aws_subnets.private.ids

  database_name = "tfe"
  username      = "tfeadmin"

  postgres_version                      = "17.7"
  allowed_cidr_blocks                   = [data.aws_vpc.rds.cidr_block]
  backup_retention_period               = 0
  deletion_protection                   = false
  skip_final_snapshot                   = true
  database_insights_mode                = "advanced"
  performance_insights_retention_period = 465
}
