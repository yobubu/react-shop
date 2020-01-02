resource "aws_iam_role" "codedeploy_service_role" {
  name = "codedeploy-service-role"

  assume_role_policy = file("${path.module}/iam-policies/codedeploy-service-role.json")
}

resource "aws_iam_role_policy_attachment" "bgshop_AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.codedeploy_service_role.name
}

resource "aws_codedeploy_app" "bgshop_app" {
  name             = "bgshop-app"
}

resource "aws_codedeploy_deployment_group" "bgshop_deploy_group" {
  app_name              = aws_codedeploy_app.bgshop_app.name
  deployment_group_name = "bgshop-deploy-group"
  service_role_arn      = aws_iam_role.codedeploy_service_role.arn
  deployment_config_name = "CodeDeployDefault.OneAtATime"

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "CodeDeployEc2"
    }

  }
  depends_on = [
    aws_codedeploy_app.bgshop_app
  ]
}