resource "aws_cloudwatch_log_group" "application_log_group" {
  name              = "/aws/ecs/backend-ecs-cluster/"
  retention_in_days = var.cloudwatch_logs_retention
  tags              = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "errors" {
  name           = "ERROR"
  pattern        = <<PATTERN
{ ($.level = "ERROR") }
PATTERN
  log_group_name = aws_cloudwatch_log_group.application_log_group.name

  metric_transformation {
    name      = "AppErrors"
    namespace = "Logs"
    value     = "1"
  }
}