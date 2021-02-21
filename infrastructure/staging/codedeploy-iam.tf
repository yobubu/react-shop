resource "aws_iam_role" "codedeploy_service_role" {
  name               = "${var.project}-${var.stage}-iam-codedeploy-service-role"
  description        = "Allows CodeDeploy to call AWS services such as Auto Scaling on your behalf."
  assume_role_policy = file("${path.module}/iam-policies/codedeploy-service-role.json")

  tags = {
    Project     = var.project
    Environment = var.stage
    Terraform   = true
  }
}

# There is an AWS managed policy called AWSCodeDeployRole already in place
resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  role       = aws_iam_role.codedeploy_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}
