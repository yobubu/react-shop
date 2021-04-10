resource "aws_ecs_cluster" "ecs_cluster" {
  name = "backend-api"
}

resource "aws_ecs_service" "ecs_service_backend" {
  name            = "ecs-service-backend"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_def_backend.arn
  desired_count   = 1
  health_check_grace_period_seconds = 60
  launch_type = "FARGATE"

  network_configuration {
    subnets = ["subnet-0a01892d619f53c95","subnet-028917c95f5fc11e2","subnet-0092786f6e3247487"]
    security_groups = [ "sg-003c309b32c12a97a" ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group_backend_api.arn
    container_name   = "nginx"
    container_port   = 80
  }
}

resource "aws_ecs_task_definition" "ecs_task_def_backend" {
  family = "backend-api-task-def"
  network_mode = "awsvpc"
  requires_compatibilities = [ "FARGATE" ]
  cpu       = 256
  memory    = 1024
  container_definitions = file("./container.json")
}