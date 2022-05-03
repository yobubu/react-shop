output "aws_vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "aws_vpc_private_subnets" {
  description = "List of the IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "aws_vpc_public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}