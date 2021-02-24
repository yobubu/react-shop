/*
  Domain: Don't forget to provide domain in variables.tf
  Registrar: If any external Registrar - please fill
  Hosted on: 
  Zone created manually
*/
data "aws_route53_zone" "main" {
  name = var.domain
}

resource "aws_route53_record" "app" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "tools.${data.aws_route53_zone.main.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.tools.public_ip]
}