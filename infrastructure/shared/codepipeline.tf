resource "aws_codestarconnections_connection" "github" {
  name          = "mygithub"
  provider_type = "GitHub"
}

# CLIENT POIPELINE

resource "aws_codepipeline" "client_pipeline" {
  name     = "${local.stack_name}-client-pipeline"
  role_arn = aws_iam_role.client_codepipeline.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      namespace        = "SourceVariables"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        ConnectionArn        = aws_codestarconnections_connection.github.arn
        FullRepositoryId     = "yobubu/react-shop"
        BranchName           = "devops-project"
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      namespace        = "BuildVariables"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.build_client.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      namespace       = "DeployVariables"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["BuildArtifact"]
      version         = "1"

      configuration = {
        BucketName = "react-shop-yobubu"
        Extract    = "true"
      }
    }
  }
}

# API CODEPIPELINE

resource "aws_codepipeline" "api_pipeline" {
  name     = "${local.stack_name}-api-pipeline"
  role_arn = aws_iam_role.api_codepipeline.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      namespace        = "SourceVariables"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        ConnectionArn        = aws_codestarconnections_connection.github.arn
        FullRepositoryId     = "yobubu/react-shop"
        BranchName           = "devops-branch"
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      namespace        = "BuildVariables"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.build_api.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      namespace       = "DeployVariables"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["BuildArtifact"]
      version         = "1"

      configuration = {
        ProjectName = aws_codebuild_project.deploy_api.name
      }
    }
  }
}