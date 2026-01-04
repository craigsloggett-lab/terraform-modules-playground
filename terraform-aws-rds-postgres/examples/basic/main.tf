data "aws_vpc" "rds" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

module "terraform_aws_rds_postgres" {
  source = "../../"

  identifier = "tfe-postgres-db-001"
  vpc_id     = data.aws_vpc.rds.id
  subnet_ids = var.database_subnet_ids

  database_name = "terraform_enterprise"
  username      = "tfeadmin"

  allowed_cidr_blocks     = [data.aws_vpc.rds.cidr_block]
  backup_retention_period = 0
  deletion_protection     = false
  skip_final_snapshot     = true
}
