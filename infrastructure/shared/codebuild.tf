# CLIENT CODEBUILD

resource "aws_codebuild_project" "build_client" {
  name          = "${local.stack_name}-client-build"
  description   = "${local.stack_name}-client-build"
  build_timeout = "60"
  service_role  = aws_iam_role.client_codebuild.arn

  artifacts {
    packaging = "NONE"
    type      = "CODEPIPELINE"
  }

  cache {
    type = "NO_CACHE"
  }

  environment {
    privileged_mode             = true
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "ECR_CLIENT_URL"
      value = aws_ecr_repository.client.repository_url
    }

  }

  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.client_build.name
    }

  }

  vpc_config {
    vpc_id = module.vpc.vpc_id

    subnets = module.vpc.private_subnets

    security_group_ids = [module.vpc.default_security_group_id]
  }

  source {
    buildspec       = "codebuild/build-client.yml"
    type            = "CODEPIPELINE"
    git_clone_depth = 0
  }

}

# API CODEBUILD

resource "aws_codebuild_project" "build_api" {
  name          = "${local.stack_name}-api-build"
  description   = "${local.stack_name}-api-build"
  build_timeout = "60"
  service_role  = aws_iam_role.api_codebuild.arn

  artifacts {
    packaging = "NONE"
    type      = "CODEPIPELINE"
  }

  cache {
    type = "NO_CACHE"
  }

  environment {
    privileged_mode             = false
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "ECR_API_URL"
      value = aws_ecr_repository.api.repository_url
    }

  }

  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.api_build.name
    }

  }

  vpc_config {
    vpc_id = module.vpc.vpc_id

    subnets = module.vpc.public_subnets

    security_group_ids = [module.vpc.default_security_group_id]
  }

  source {
    buildspec       = "codebuild/build-api.yml"
    type            = "CODEPIPELINE"
    git_clone_depth = 0
  }

}

# API CODEDEPLOY

resource "aws_codebuild_project" "deploy_api" {
  name          = "${local.stack_name}-api-deploy"
  description   = "${local.stack_name}-api-deploy"
  build_timeout = "60"
  service_role  = aws_iam_role.api_codedeploy.arn

  artifacts {
    packaging = "NONE"
    type      = "CODEPIPELINE"
  }

  cache {
    type = "NO_CACHE"
  }

  environment {
    privileged_mode             = true
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    # environment_variable {
    #   name  = "ECR_API_URL"
    #   value = aws_ecr_repository.api.repository_url
    # }

  }

  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.api_deploy.name
    }

  }

  vpc_config {
    vpc_id = module.vpc.vpc_id

    subnets = module.vpc.private_subnets

    security_group_ids = [module.vpc.default_security_group_id]
  }

  source {
    buildspec       = "codebuild/deploy-api.yml"
    type            = "CODEPIPELINE"
    git_clone_depth = 0
  }

}