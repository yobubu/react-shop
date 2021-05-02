locals {
  website-bucket-name = aws_s3_bucket.website-bucket.id
}

resource "aws_s3_bucket" "website-bucket" {
  bucket        = "${var.project}-${var.region}-${var.environment}-website-bucket"
  acl           = "public-read"
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "index.html"

  }
}

resource "aws_s3_bucket_policy" "website-bucket-policy" {
  bucket = local.website-bucket-name
  policy = data.aws_iam_policy_document.website-bucket-policy.json
}

data "aws_iam_policy_document" "website-bucket-policy" {
  statement {
    sid = "allow-public-access"
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${local.website-bucket-name}/*"
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket" "variables-bucket" {
  bucket        = "${var.project}-${var.region}-${var.environment}-variables-bucket"
  acl           = "private"
  force_destroy = true
}