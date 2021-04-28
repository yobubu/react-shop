variable "project" {
  type = string
  default = "react-shop"
  description = "Project name eg. react-shop"
}
variable "region" {
  type    = string
  default = "ap-southeast-1"
  description = "AWS Region"
}

variable "environment" {
  type = string
  default = "dev"
  description = "Environment eg. dev, qa, uat, prod"
}

variable "domain" {
  type = string
  default = "shop.devops.codes"
  description = "Hosted Zone created in Route 53 to use with ALB & CloudFront"
}

variable "docdb_master_user" {
  type = string
  default = "sammysammy"
  description = "User name for AWS Document DB"
}

variable "docdb_master_pass" {
  type = string
  default = "dummydummy"
  description = "Password for AWS Document DB"
}