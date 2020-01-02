resource "aws_s3_bucket" "bgshop_codedeploy_bucket" {
  bucket = "bgshop-codedeploy-bucket"
  acl    = "private"

  region = "eu-central-1"

  versioning {
    enabled = false
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name      = "S3 Bgshop CodeDeploy Bucket"
  }
}