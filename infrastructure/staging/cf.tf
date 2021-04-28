resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "${var.project}-${var.environment} origin access identity"
}

resource "aws_cloudfront_distribution" "default_distribution" {
  origin {
    domain_name = aws_s3_bucket.website-bucket.bucket_regional_domain_name
    origin_id   = "website"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  aliases = [
    var.domain
  ]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "website"

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }


    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  tags = {
    Project     = var.project
    Environment = var.environment
    Terraform   = true
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = aws_acm_certificate.cdn_cert.arn
    ssl_support_method             = "sni-only"
  }

  depends_on = [aws_acm_certificate_validation.cdn_cert]
}