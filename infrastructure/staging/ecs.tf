resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.project}-${var.environment}-backend-ecs-cluster"
}

resource "aws_ecs_service" "ecs_service_backend" {
  name                              = "${var.project}-${var.environment}-backend-ecs-service"
  cluster                           = aws_ecs_cluster.ecs_cluster.id
  task_definition                   = aws_ecs_task_definition.ecs_task.arn
  desired_count                     = 1
  health_check_grace_period_seconds = 60
  launch_type                       = "FARGATE"

  network_configuration {
    subnets         = data.terraform_remote_state.network_remote_state.outputs.aws_vpc_private_subnets
    security_groups = [aws_security_group.backend_allow_http.id, aws_security_group.documentdb.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group_backend_api.arn
    container_name   = "${var.project}-${var.environment}"
    container_port   = var.app_port
  }
}

# see https://github.com/cloudposse/terraform-aws-ecs-container-definition/blob/master/variables.tf
module "ecs-task-container" {
  source          = "git::https://github.com/cloudposse/terraform-aws-ecs-container-definition?ref=tags/0.56.0"
  container_name  = "${var.project}-${var.environment}"
  container_image = var.app_image
  essential       = true
  environment_files = [
    {
      value = "${aws_s3_bucket.variables-bucket.arn}/${var.environment}.env"
      type  = "s3"
    }
  ]
  entrypoint                   = var.app_entrypoint
  command                      = var.app_command
  readonly_root_filesystem     = false
  container_cpu                = null
  container_memory             = null
  container_memory_reservation = null
  start_timeout                = 30
  stop_timeout                 = 30

  port_mappings = [
    {
      containerPort = var.app_port
      hostPort      = var.app_port
      protocol      = "tcp"
    },
  ]

  log_configuration = {
    logDriver     = "awslogs"
    secretOptions = null
    options = {
      awslogs-region        = var.region
      awslogs-group         = aws_cloudwatch_log_group.application_log_group.name
      awslogs-stream-prefix = "ecs"
    }
  }
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                   = var.project
  tags                     = var.tags
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  task_role_arn            = aws_iam_role.task_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.app_fargate_cpu
  memory                   = var.app_fargate_memory
  container_definitions    = module.ecs-task-container.json_map_encoded_list
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