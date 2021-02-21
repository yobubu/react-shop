resource "aws_alb" "load_balancer" {
  name            = "${var.project}-loadbalancer"
  security_groups = [aws_security_group.loadbalancer.id]
  subnets         = flatten([data.terraform_remote_state.network_remote_state.outputs.aws_vpc_public_subnets.*])

  tags = {
    Name        = "${var.project}-loadbalancer"
    Project     = var.project
    Environment = var.stage
    Terraform   = true
  }
}

resource "aws_alb_listener" "alb_http" {
  load_balancer_arn = aws_alb.load_balancer.arn
  port              = var.alb_http_port
  protocol          = var.alb_http_protocol

  default_action {
    type = var.alb_http_default_action_type

    redirect {
      port        = var.alb_http_redirect_port
      protocol    = var.alb_http_redirect_protocol
      status_code = var.alb_http_redirect_status_code
      query       = var.alb_http_redirect_query
    }
  }
  depends_on = [aws_alb.load_balancer]
}

resource "aws_alb_listener" "alb_https" {
  load_balancer_arn = aws_alb.load_balancer.arn
  port              = var.alb_https_port
  protocol          = var.alb_https_protocol
  ssl_policy        = var.alb_https_ssl_policy
  certificate_arn   = aws_acm_certificate.lb_cert.arn

  default_action {
    type             = var.alb_https_default_action_type
    target_group_arn = aws_alb_target_group.codedeploy_backend_target_group.arn
  }

  depends_on = [aws_alb.load_balancer, aws_acm_certificate_validation.lb_cert]
}

################################################################################
resource "aws_alb_target_group" "codedeploy_backend_target_group" {
  port     = var.codedeploy_backend_target_group_port
  protocol = var.codedeploy_backend_target_group_protocol
  vpc_id   = data.terraform_remote_state.network_remote_state.outputs.aws_vpc_id
  health_check {
    healthy_threshold   = var.codedeploy_backend_target_group_hc_healthy_threshold
    unhealthy_threshold = var.codedeploy_backend_target_group_hc_unhealthy_threshold
    interval            = var.codedeploy_backend_target_group_hc_interval
    matcher             = var.codedeploy_backend_target_group_hc_matcher
    path                = var.codedeploy_backend_target_group_hc_path
    port                = var.codedeploy_backend_target_group_hc_port
    protocol            = var.codedeploy_backend_target_group_hc_protocol
    timeout             = var.codedeploy_backend_target_group_hc_timeout
  }
  deregistration_delay = var.codedeploy_backend_target_group_deregistration_delay

  lifecycle {
    create_before_destroy = "true"
  }

  tags = {
    Name        = "${var.project}_codedeploy_backend_target_group"
    Project     = var.project
    Environment = var.stage
    Terraform   = true
  }
}