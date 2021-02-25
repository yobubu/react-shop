resource "aws_iam_role" "ec2-tools-role" {
  name               = "ec2-tools-role"
  assume_role_policy = file("${path.module}/templates/ec2-tools-role.json")
}

resource "aws_iam_role_policy_attachment" "ec2-tools-SSM-policy-attach" {
  role       = aws_iam_role.ec2-tools-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ec2-tools-read-policy-attach" {
  role       = aws_iam_role.ec2-tools-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "ec2-tools-profile" {
  name = "ec2-tools-profile"
  role = aws_iam_role.ec2-tools-role.id
}

resource "aws_iam_policy" "ec2_tools_role_custom_policy" {
  name   = "${var.project}-${var.environment}-iam-ec2-tools-custom-policy"
  policy = file("${path.module}/iam-policies/ec2-tools-role-policy.json")
}

resource "aws_iam_role_policy_attachment" "attach_ec2_tools_role_custom_policy" {
  role       = aws_iam_role.ec2-tools-role.name
  policy_arn = aws_iam_policy.ec2_tools_role_custom_policy.arn
  depends_on = [aws_iam_role.ec2-tools-role]
}