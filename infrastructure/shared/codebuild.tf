resource "aws_codebuild_project" "build_client" {
  name          = "build-client"
  description   = "Build client"
  build_timeout = "60"
  service_role  = "arn:aws:iam::141917287833:role/service-role/codebuild-build-client-service-role"

  artifacts {
    packaging              = "NONE"
    type                   = "CODEPIPELINE"
  }

  cache {
    type     = "NO_CACHE"
  }

  environment {
    privileged_mode             = true
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "S3-BUCKET_NAME"
      value = "react-shop-yobubu"
    }

  }

  logs_config {
    cloudwatch_logs {
      group_name  = "build-client"
    }

  }

  source {
    buildspec       = "codebuild/build-client.yml"
    type            = "CODEPIPELINE"
    git_clone_depth = 0
  }

}
