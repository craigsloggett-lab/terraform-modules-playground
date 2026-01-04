# CloudWatch log group for slow-log (if configured)
resource "aws_cloudwatch_log_group" "slow_log" {
  count = length([for config in var.log_delivery_configuration : config if config.log_type == "slow-log"]) > 0 ? 1 : 0

  name              = "/aws/elasticache/${var.identifier}/slow-log"
  retention_in_days = var.cloudwatch_logs_retention_days

  tags = {
    Name    = "${var.identifier}-slow-log"
    LogType = "slow-log"
  }
}

# CloudWatch log group for engine-log (if configured)
resource "aws_cloudwatch_log_group" "engine_log" {
  count = length([for config in var.log_delivery_configuration : config if config.log_type == "engine-log"]) > 0 ? 1 : 0

  name              = "/aws/elasticache/${var.identifier}/engine-log"
  retention_in_days = var.cloudwatch_logs_retention_days

  tags = {
    Name    = "${var.identifier}-engine-log"
    LogType = "engine-log"
  }
}
