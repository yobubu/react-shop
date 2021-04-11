resource "aws_lb" "alb_backend_api" {
  name               = "backend-api-load-balancer"
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
  name                 = "backend-api-target-group"
  port                 = 80
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
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_backend_api.arn
  }
}