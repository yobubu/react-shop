resource "aws_codepipeline" "client_pipeline" {
  name     = "client-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"

    # encryption_key {
    #   id   = data.aws_kms_alias.s3kmskey.arn
    #   type = "KMS"
    # }
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
        ProjectName = "build-client"
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
      provider        = "S3"
      input_artifacts = ["BuildArtifact"]
      version         = "1"

      configuration = {
        BucketName = "react-shop-yobubu"
        Extract    = "true"
      }
    }
  }
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "codepipeline-eu-west-1-406900656095"
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.codepipeline_bucket.id
}

resource "aws_iam_role" "codepipeline_role" {
  name               = "AWSCodePipelineServiceRole-eu-west-1-client-pipeline"
  path               = "/service-role/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# # resource "aws_iam_role_policy" "codepipeline_policy" {
# #   name = "AWSCodePipelineServiceRole-eu-west-1-client-pipeline"
# #   role = aws_iam_role.codepipeline_role.id

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect":"Allow",
#       "Action": [
#         "s3:GetObject",
#         "s3:GetObjectVersion",
#         "s3:GetBucketVersioning",
#         "s3:PutObjectAcl",
#         "s3:PutObject"
#       ],
#       "Resource": [
#         "${aws_s3_bucket.codepipeline_bucket.arn}",
#         "${aws_s3_bucket.codepipeline_bucket.arn}/*"
#       ]
#     },
#     {
#       "Effect": "Allow",
#       "Action": [
#         "codestar-connections:UseConnection"
#       ],
#       "Resource": "${aws_codestarconnections_connection.github.arn}"
#     },
#     {
#       "Effect": "Allow",
#       "Action": [
#         "codebuild:BatchGetBuilds",
#         "codebuild:StartBuild"
#       ],
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

resource "aws_codestarconnections_connection" "github" {
  name          = "mygithub"
  provider_type = "GitHub"
}

# data "aws_kms_alias" "s3kmskey" {
#   name = "alias/myKmsKey"
# }