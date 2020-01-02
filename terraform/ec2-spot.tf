# Request a spot instance at $0.03
provider "aws" {
  region     = "eu-central-1"
}

resource "aws_spot_instance_request" "code_deploy_ec2" {
  ami           = "ami-0d4c3eabb9e72650a"
  spot_price    = "0.007"
  instance_type = "t2.micro"

  tags = {
    Name = "CodeDeployEc2"
  }
}

resource "aws_codedeploy_app" "bgshop-app" {
  compute_platform = "Server"          # can be either ECS, Lambda, or Server (EC2). Default is Server.
  name             = "bgshop-app"
}

resource "aws_codedeploy_deployment_config" "bgshop-app" {
  deployment_config_name = "test-deployment-config"

  minimum_healthy_hosts {
    type  = "HOST_COUNT"
    value = 1
  }
}

resource "aws_codedeploy_deployment_group" "foo" {
  app_name               = "${aws_codedeploy_app.bgshop-app.name}"
  deployment_group_name  = "bgshop"
  service_role_arn       = "${aws_iam_role.foo_role.arn}"
  deployment_config_name = "${aws_codedeploy_deployment_config.bgshop-app.id}"

  ec2_tag_filter {
    key   = "filterkey"
    type  = "KEY_AND_VALUE"
    value = "filtervalue"
  }

  trigger_configuration {
    trigger_events     = ["DeploymentFailure"]
    trigger_name       = "foo-trigger"
    trigger_target_arn = "foo-topic-arn"
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  alarm_configuration {
    alarms  = ["my-alarm-name"]
    enabled = true
  }
}# Request a spot instance at $0.03
provider "aws" {
  region     = "eu-central-1"
}

resource "aws_spot_instance_request" "code_deploy_ec2" {
  ami           = "ami-0d4c3eabb9e72650a"
  spot_price    = "0.007"
  instance_type = "t2.micro"

  tags = {
    Name = "CodeDeployEc2"
  }
}

resource "aws_codedeploy_app" "bgshop-app" {
  compute_platform = "Server"          # can be either ECS, Lambda, or Server (EC2). Default is Server.
  name             = "bgshop-app"
}

resource "aws_codedeploy_deployment_config" "bgshop-app" {
  deployment_config_name = "test-deployment-config"

  minimum_healthy_hosts {
    type  = "HOST_COUNT"
    value = 1
  }
}

resource "aws_codedeploy_deployment_group" "foo" {
  app_name               = "${aws_codedeploy_app.bgshop-app.name}"
  deployment_group_name  = "bgshop"
  service_role_arn       = "${aws_iam_role.foo_role.arn}"
  deployment_config_name = "${aws_codedeploy_deployment_config.bgshop-app.id}"

  ec2_tag_filter {
    key   = "filterkey"
    type  = "KEY_AND_VALUE"
    value = "filtervalue"
  }

  trigger_configuration {
    trigger_events     = ["DeploymentFailure"]
    trigger_name       = "foo-trigger"
    trigger_target_arn = "foo-topic-arn"
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  alarm_configuration {
    alarms  = ["my-alarm-name"]
    enabled = true
  }
}