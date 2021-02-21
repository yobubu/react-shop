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

  tags = merge(var.default_tags)
}