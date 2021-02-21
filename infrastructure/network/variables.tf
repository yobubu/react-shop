variable "project" {
  type    = string
  default = "toptal-task"
}

variable "environment" {
  type    = string
  default = "global"
}

variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "aws_vpc_name" {
  type    = string
  default = "vpc"
}
variable "aws_vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  type    = list
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  type    = list
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "default_tags" {
  type = map(string)
  default = {
    Name        = "vpc"
    Project     = "toptal-task"
    Environment = "stage"
    Terraform   = true
  }
}

###############################
### LOCALS ####################
###############################

locals {
  aws_region_azs = formatlist("%s%s", var.region, ["a", "b", "c"])
}