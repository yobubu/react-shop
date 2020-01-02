resource "aws_iam_role" "codedeploy-service-role" {
  name = "codedeploy-service-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.codedeploy-service-role.name
}

resource "aws_codedeploy_app" "bgshop-app" {
  name             = "bgshop-app"
}

resource "aws_codedeploy_deployment_group" "bgshop-deploy-group" {
  app_name              = aws_codedeploy_app.bgshop-app.name
  deployment_group_name = "bgshop-deploy-group"

  service_role_arn      = aws_iam_role.codedeploy-service-role.arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "CodeDeployEc2"
    }

  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}