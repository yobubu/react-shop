output "aws_vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "aws_vpc_private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "aws_vpc_public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "aws_vpc_nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

output "aws_vpc_cidr_block" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.vpc_cidr_block
}

output "aws_vps_availability_zones" {
  description = "List of Availability Zones used by VPC subnets"
  value       = local.aws_region_azs
}