resource "aws_cloudwatch_metric_alarm" "service_cpu_high" {
  alarm_name          = "${var.project}-${var.environment}-cpu-utilization-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "85"
  unit                = "Percent"
  #tags                = var.tags
  alarm_actions = [module.ecs_cloudwatch_autoscaling.scale_up_policy_arn]

  dimensions = {
    ClusterName = aws_ecs_cluster.ecs_cluster.name
    ServiceName = aws_ecs_service.ecs_service_backend.name
  }
}

resource "aws_cloudwatch_metric_alarm" "service_cpu_low" {
  alarm_name          = "${var.project}-${var.environment}-cpu-utilization-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"
  unit                = "Percent"
  #tags                = var.tags
  alarm_actions = [module.ecs_cloudwatch_autoscaling.scale_down_policy_arn]

  dimensions = {
    ClusterName = aws_ecs_cluster.ecs_cluster.name
    ServiceName = aws_ecs_service.ecs_service_backend.name
  }
}