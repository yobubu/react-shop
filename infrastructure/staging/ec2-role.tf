resource "aws_iam_role" "ec2_instance_role" {
  name               = "${var.project}-${var.stage}-ec2-instance-role"
  assume_role_policy = file("${path.module}/iam-policies/ec2-instance-role.json")

  tags = {
    Project     = var.project
    Environment = var.stage
    Terraform   = true
  }
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  role       = aws_iam_role.ec2_instance_role.name
  name       = "${var.project}-${var.stage}-ec2-instance-profile"
  depends_on = [aws_iam_role.ec2_instance_role]
}

resource "aws_iam_policy" "ec2_instance_role_custom_policy" {
  name   = "${var.project}-${var.stage}-iam-ec2-custom-policy"
  policy = file("${path.module}/iam-policies/ec2-instance-role-policy.json")
}

resource "aws_iam_role_policy_attachment" "attach_ec2_instance_role_custom_policy" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = aws_iam_policy.ec2_instance_role_custom_policy.arn
  depends_on = [aws_iam_role.ec2_instance_role]
}
