resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.project}-${var.environment}-backend-ecs-cluster"
}

resource "aws_ecs_service" "ecs_service_backend" {
  name                              = "${var.project}-${var.environment}-backend-ecs-service"
  cluster                           = aws_ecs_cluster.ecs_cluster.id
  task_definition                   = aws_ecs_task_definition.ecs_task_def_backend.arn
  desired_count                     = 1
  health_check_grace_period_seconds = 60
  launch_type                       = "FARGATE"

  network_configuration {
    subnets         = data.terraform_remote_state.network_remote_state.outputs.aws_vpc_private_subnets
    security_groups = [aws_security_group.backend_allow_http.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group_backend_api.arn
    container_name   = "nginx"
    container_port   = 80
  }
}

resource "aws_ecs_task_definition" "ecs_task_def_backend" {
  family                   = "${var.project}-${var.environment}-task-def"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  container_definitions    = file("./container.json")
}

module "ecs_cloudwatch_autoscaling" {
  source                = "cloudposse/ecs-cloudwatch-autoscaling/aws"
  version               = "0.7.0"
  namespace             = "backend"
  stage                 = var.environment
  name                  = var.project
  service_name          = aws_ecs_service.ecs_service_backend.name
  cluster_name          = aws_ecs_cluster.ecs_cluster.name
  min_capacity          = 1
  max_capacity          = 2
  scale_up_adjustment   = 1
  scale_up_cooldown     = 60
  scale_down_adjustment = -1
  scale_down_cooldown   = 300
}