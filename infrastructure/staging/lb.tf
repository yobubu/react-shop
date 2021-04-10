resource "aws_lb" "alb_backend_api" {
  name               = "backend-api-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-003c309b32c12a97a"]
  subnets            = ["subnet-0756b4357cd900d66","subnet-09945a26251949647","subnet-0aba583a7d29a94ed"]

  enable_deletion_protection = false

  tags = {
    Environment = "dev"
  }
}

resource "aws_lb_target_group" "target_group_backend_api" {
  name        = "backend-api-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "vpc-0f559810e7e2ba5e8"
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