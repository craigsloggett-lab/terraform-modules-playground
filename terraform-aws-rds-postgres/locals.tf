locals {
  postgres_major_version = split(".", var.postgres_version)[0]

  parameter_group_name   = var.parameter_group_name != null ? var.parameter_group_name : "${var.identifier}-pg"
  parameter_group_family = "postgres${local.postgres_major_version}"

  security_group_name = var.security_group_name != null ? var.security_group_name : "${var.identifier}-sg"
  subnet_group_name   = var.subnet_group_name != null ? var.subnet_group_name : "${var.identifier}-subnet-group"

  rds_kms_key_id             = var.rds_kms_key_id != null ? var.rds_kms_key_id : "alias/aws/rds"
  secrets_manager_kms_key_id = var.secrets_manager_kms_key_id != null ? var.secrets_manager_kms_key_id : "alias/aws/secretsmanager"

  final_snapshot_identifier = "${var.identifier}-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
}
