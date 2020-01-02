resource "aws_instance" "code_deploy_ec2" {
  ami           = "ami-0d4c3eabb9e72650a"
  instance_type = "t2.micro"

  tags = {
    Name = "CodeDeployEc2"
  }
}

resource "aws_iam_role" "ec2_instance_role" {
  name               = "bgshop-iam-ec2-instance-role"
  assume_role_policy = file("${path.module}/iam-policies/ec2-instance-trust.json")
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  role = aws_iam_role.ec2_instance_role.name
  name = "bgshop-iam-ec2-instance-profile"

  depends_on = [aws_iam_role.ec2_instance_role]
}

/*
  Session Manager lets us avoid spinning up a dedicated Bastion Host.
  Simply login to System Manager -> Session Manager and start a terminal session for
  the instance you might need to manage manually.
*/

resource "aws_ssm_activation" "ssm_activate" {
  name        = "bgshop-iam-ssm-activation"
  description = "SSM Session Manager document activation"
  iam_role    = aws_iam_role.ec2_instance_role.id

  # The maximum number of managed instances you want to register. The default value is 1 instance.
  registration_limit = "5"
}

data "template_file" "bgshop_custom_policy_actions" {
  template = file("${path.module}/iam-policies/bgshop-ec2-instance-role-policy.json")
}

resource "aws_iam_policy" "bgshop_custom_policy_actions" {
  name       = "bgshop-iam-custom-policy-actions"
  policy     = data.template_file.bgshop_custom_policy_actions.rendered
  depends_on = [data.template_file.bgshop_custom_policy_actions]
}

resource "aws_iam_role_policy_attachment" "bgshop_attach_custom_policy" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = aws_iam_policy.bgshop_custom_policy_actions.arn
  depends_on = [aws_iam_role.ec2_instance_role]
}