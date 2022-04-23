resource "aws_lb" "public_lb" {
  name               = "${local.stack_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_lb.id, aws_security_group.backend_ecs.id]
  subnets            = ["subnet-056e79af0730eabe3", "subnet-0ba658937aa4e62d4", "subnet-07f20734668e0e517"]

  enable_deletion_protection = false
}

resource "aws_lb_listener" "public_lb_http" {
  load_balancer_arn = aws_lb.public_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_backend.arn
  }
}

resource "aws_lb_target_group" "ecs_backend" {
  name        = "${local.stack_name}-ecs-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "vpc-0b7f23f3f624eb838"
}