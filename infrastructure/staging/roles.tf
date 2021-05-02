locals {
  iam_path = "/service-role/"
}

data "aws_iam_policy_document" "assume-ecs-tasks" {
  statement {
    sid     = "AssumeECSTasks"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "task_execution_role" {
  name_prefix           = substr("${var.project}-${var.environment}-task-exec", 0, 32)
  tags                  = var.tags
  path                  = local.iam_path
  assume_role_policy    = data.aws_iam_policy_document.assume-ecs-tasks.json
  force_detach_policies = true
}

# IAM Permissions required to start a new task
# docs: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html
# example role: arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy
data "aws_iam_policy_document" "task_execution_policy" {
  statement {
    sid    = "PutLogsToCloudwatch"
    effect = "Allow"
    resources = [
      "${aws_cloudwatch_log_group.application_log_group.arn}:*"
    ]
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
  }

  statement {
    sid       = "AccessS3Envs"
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["*"]
  }

  statement {
    sid       = "AllowToPullImageFromECR"
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    ]
  }
}

resource "aws_iam_role_policy" "task_execution_policy" {
  name_prefix = substr("${var.project}-${var.environment}-task-exec", 0, 64)
  role        = aws_iam_role.task_execution_role.name
  policy      = data.aws_iam_policy_document.task_execution_policy.json
}

resource "aws_iam_role" "task_role" {
  name_prefix           = substr("${var.project}-${var.environment}-task", 0, 32)
  tags                  = var.tags
  path                  = local.iam_path
  assume_role_policy    = data.aws_iam_policy_document.assume-ecs-tasks.json
  force_detach_policies = true
}

# IAM Permissions for the task
# docs: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html
data "aws_iam_policy_document" "task_policy" {
  statement {
    sid    = "AccessToUploadS3Bucket"
    effect = "Allow"
    resources = [
      "arn:aws:s3:::*"
    ]
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject"
    ]
  }
}

resource "aws_iam_role_policy" "task_policy" {
  name_prefix = substr("${var.project}-${var.environment}-task", 0, 64)
  role        = aws_iam_role.task_role.name
  policy      = data.aws_iam_policy_document.task_policy.json
}
