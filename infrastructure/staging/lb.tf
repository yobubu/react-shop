resource "aws_lb" "alb_backend_api" {
  name               = "${var.project}-${var.environment}-backend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_allow_http.id, aws_security_group.backend_allow_http.id]
  subnets            = data.terraform_remote_state.network_remote_state.outputs.aws_vpc_public_subnets

  enable_deletion_protection = false

  tags = {
    Environment = "dev"
  }
}

resource "aws_lb_target_group" "target_group_backend_api" {
  name                 = "${var.project}-${var.environment}-backend-tg"
  port                 = var.app_port
  protocol             = "HTTP"
  target_type          = "ip"
  vpc_id               = data.terraform_remote_state.network_remote_state.outputs.aws_vpc_id
  deregistration_delay = 10
}

resource "aws_lb_listener" "alb_backend_api_listener" {
  load_balancer_arn = aws_lb.alb_backend_api.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
      query       = "#{query}"
    }
  }
  depends_on = [aws_lb.alb_backend_api]
}

resource "aws_alb_listener" "alb_backend_api_listener_https" {
  load_balancer_arn = aws_lb.alb_backend_api.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = aws_acm_certificate.lb_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_backend_api.arn
  }

  depends_on = [aws_lb.alb_backend_api, aws_acm_certificate_validation.lb_cert]
}