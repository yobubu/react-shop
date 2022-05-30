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
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = 1


  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_backend.arn
    container_name   = "backend"
    container_port   = 2370
  }

  network_configuration {
    subnets         = data.terraform_remote_state.shared_remote_state.outputs.aws_vpc_private_subnets
    security_groups = [aws_security_group.backend_ecs.id, aws_security_group.docdb.id]
  }
}

resource "aws_ecs_task_definition" "backend" {
  family                   = "${local.stack_name}-backend-ecs-task-def"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = aws_iam_role.backend_task_execution.arn
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "api",
    "image": "${var.api_image}",
    "cpu": 1024,
    "memory": 2048,
    "essential": true,
    "portMappings": [
        {
          "containerPort": 2370,
          "hostPort": 2370
        }
    ],
    "environment": [
      {"name": "MONGO_USER", "value": "sammy"},
      {"name": "MONGO_PASS", "value": "${random_password.docdb_password.result}"},
      {"name": "MONGO_CONN_STRING", "value": "${aws_docdb_cluster.docdb.endpoint}:27017/sample-database?tls=true&replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false"},
      {"name": "MONGO_DB", "value": "shop"},
      {"name": "JWT_SECRET", "value": "randomstring"}
    ],
    "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "${aws_cloudwatch_log_group.backend_ecs.name}",
                    "awslogs-region": "${var.region}",
                    "awslogs-stream-prefix": "api"
                }
            }
  }
]
TASK_DEFINITION


  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"

  }
}