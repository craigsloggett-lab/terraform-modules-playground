resource "aws_cloudwatch_log_group" "postgresql" {
  name              = "/aws/rds/instance/${var.identifier}/postgresql"
  retention_in_days = var.cloudwatch_logs_retention_days

  tags = {
    Name    = "${var.identifier}-postgresql-logs"
    LogType = "postgresql"
  }
}

resource "aws_cloudwatch_log_group" "upgrade" {
  name              = "/aws/rds/instance/${var.identifier}/upgrade"
  retention_in_days = var.cloudwatch_logs_retention_days

  tags = {
    Name    = "${var.identifier}-upgrade-logs"
    LogType = "upgrade"
  }
}
