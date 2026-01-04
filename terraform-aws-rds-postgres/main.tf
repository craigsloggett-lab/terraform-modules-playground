resource "aws_db_subnet_group" "this" {
  name       = local.subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = local.subnet_group_name
  }
}

resource "aws_db_parameter_group" "this" {
  name   = local.parameter_group_name
  family = local.parameter_group_family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  tags = {
    Name = local.parameter_group_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_instance" "this" {
  # Identifier
  identifier = var.identifier

  # Engine Configuration
  engine         = "postgres"
  engine_version = var.postgres_version
  instance_class = var.instance_class

  # Database Configuration
  db_name  = var.database_name
  username = var.username

  # Network Configuration
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false

  # Storage Configuration
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = true
  iops                  = var.iops
  storage_throughput    = var.storage_throughput

  # High Availability
  multi_az = true

  # Backup Configuration
  backup_retention_period   = var.backup_retention_period
  backup_window             = var.backup_window
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = local.final_snapshot_identifier
  copy_tags_to_snapshot     = var.copy_tags_to_snapshot

  # Maintenance
  maintenance_window         = var.maintenance_window
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately          = var.apply_immediately

  # Master Password Management
  manage_master_user_password   = true
  master_user_secret_kms_key_id = data.aws_kms_key.secretsmanager.arn

  # Monitoring
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_kms_key_id       = var.performance_insights_enabled ? data.aws_kms_key.rds.arn : null
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null
  enabled_cloudwatch_logs_exports       = ["postgresql", "upgrade"]

  # Parameter Group
  parameter_group_name = aws_db_parameter_group.this.name

  # Deletion Protection
  deletion_protection = var.deletion_protection

  # Tags
  tags = {
    Name = var.identifier
  }

  # Ensure log groups exist before RDS starts logging to them. This also ensures
  # Terraform deletes the log groups after the RDS database so they aren't
  # automatically created again by the RDS service during a Terraform destroy.
  depends_on = [
    aws_cloudwatch_log_group.postgresql,
    aws_cloudwatch_log_group.upgrade
  ]
}
