resource "aws_codedeploy_app" "backend_app" {
  compute_platform = var.codedeploy_backend_compute_platform
  name             = "${var.project}-${var.stage}-main-app"
}

resource "aws_codedeploy_deployment_group" "backend" {
  app_name               = aws_codedeploy_app.backend_app.name
  deployment_group_name  = "${var.project}-${var.stage}-main-group"
  service_role_arn       = aws_iam_role.codedeploy_service_role.arn
  autoscaling_groups     = [aws_autoscaling_group.backend_asg.name]
  deployment_config_name = var.codedeploy_backend_deployment_config_name

  deployment_style {
    deployment_option = var.codedeploy_backend_deployment_option
    deployment_type   = var.codedeploy_backend_deployment_type
  }

  load_balancer_info {
    target_group_info {
      name = aws_alb_target_group.codedeploy_backend_target_group.name
    }
  }

  depends_on = [
    aws_alb_target_group.codedeploy_backend_target_group,
    aws_codedeploy_app.backend_app,
    aws_autoscaling_group.backend_asg
  ]
}