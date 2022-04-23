resource "aws_ecs_cluster" "backend" {
  name = "${local.stack_name}-backend-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "backend" {
  name            = "${local.stack_name}-backend-ecs-service"
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.backend.id
  task_definition = aws_ecs_task_definition.backend.arn #todo
  desired_count   = 2
  #   iam_role        = aws_iam_role.foo.arn #todo
  #   depends_on      = [aws_iam_role_policy.foo] #todo

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_backend.arn
    container_name   = "nginx"
    container_port   = 80
  }

  network_configuration {
    subnets         = ["subnet-07972c611ecac7842", "subnet-087cce72daa1ace31", "subnet-0bf3b650061b61c0c"]
    security_groups = [aws_security_group.backend_ecs.id]
  }
}

resource "aws_ecs_task_definition" "backend" {
  family                   = "${local.stack_name}-backend-ecs-task-def"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "nginx",
    "image": "nginx:latest",
    "cpu": 512,
    "memory": 1024,
    "essential": true,
    "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
    ]
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}