/*
  Define policy
*/

data "template_file" "s3_policy" {
  template = file("${path.module}/iam-policies/s3-policy.json")

  vars = {
    app_bucket = aws_s3_bucket.custom_bucket.arn
    web_bucket = aws_s3_bucket.website_bucket.arn
  }
}

resource "aws_iam_policy" "s3_policy" {
  name        = "${var.project}-${var.stage}-iam-s3-policy"
  description = "Custom made policy, tailored for ${var.project} project only"
  policy      = data.template_file.s3_policy.rendered
}

/*
  Attach policy to EC2 instance role
*/
resource "aws_iam_role_policy_attachment" "ec2_instance_role_s3_policy_attach" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
  depends_on = [aws_iam_role.ec2_instance_role, aws_iam_policy.s3_policy]
}