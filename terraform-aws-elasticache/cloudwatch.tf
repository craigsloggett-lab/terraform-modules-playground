resource "aws_cloudwatch_log_group" "slow_log" {
  name              = "/aws/elasticache/${var.identifier}/slow-log"
  retention_in_days = var.cloudwatch_logs_retention_days

  tags = {
    Name    = "${var.identifier}-slow-log"
    LogType = "slow-log"
  }
}

resource "aws_cloudwatch_log_group" "engine_log" {
  name              = "/aws/elasticache/${var.identifier}/engine-log"
  retention_in_days = var.cloudwatch_logs_retention_days

  tags = {
    Name    = "${var.identifier}-engine-log"
    LogType = "engine-log"
  }
}
