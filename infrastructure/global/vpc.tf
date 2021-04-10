locals {
  aws_region_azs = formatlist("%s%s", var.region, ["a", "b", "c"])
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.70.0"

  name            = "${var.project}-${var.environment}-${var.aws_vpc_name}"
  cidr            = var.aws_vpc_cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  azs = local.aws_region_azs

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_s3_endpoint   = true

  tags = var.default_tags
}