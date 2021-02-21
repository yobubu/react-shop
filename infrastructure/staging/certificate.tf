################################################################################
# Main cert
# - attached to LB as primary (cannot be detached unless recreating ALB)
resource "aws_acm_certificate" "lb_cert" {
  domain_name       = "backend.${var.domain}"
  validation_method = "DNS"

  tags = {
    Name        = var.domain
    Project     = var.project
    Environment = var.stage
    Terraform   = true
  }

  lifecycle {
    create_before_destroy = false
  }
}


resource "aws_route53_record" "lb_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.lb_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.zone_id
  records         = [each.value.record]
  ttl             = 60
}

resource "aws_acm_certificate_validation" "lb_cert" {
  certificate_arn         = aws_acm_certificate.lb_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.lb_cert_validation : record.fqdn]

  depends_on = [aws_acm_certificate.lb_cert, aws_route53_record.lb_cert_validation]
}

################################################################################
# CDN cert
# - if CDN cert then it must be located in us-east-1 region
resource "aws_acm_certificate" "cdn_cert" {
  provider = aws.us-east-1

  domain_name       = var.domain
  validation_method = "DNS"

  tags = {
    Name        = var.domain
    Project     = var.project
    Environment = var.stage
    Terraform   = true
  }

  lifecycle {
    create_before_destroy = false
  }
}


resource "aws_route53_record" "cdn_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cdn_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  provider        = aws.us-east-1
  name            = each.value.name
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.zone_id
  records         = [each.value.record]
  ttl             = 60
}

resource "aws_acm_certificate_validation" "cdn_cert" {
  provider                = aws.us-east-1
  certificate_arn         = aws_acm_certificate.cdn_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cdn_cert_validation : record.fqdn]

  depends_on = [aws_acm_certificate.cdn_cert, aws_route53_record.cdn_cert_validation]
}
