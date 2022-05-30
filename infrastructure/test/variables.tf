variable "project" {
  type        = string
  default     = "react-shop"
  description = "Name of the project"
}

variable "environment" {
  type        = string
  default     = "test"
  description = "Name of the environment"
}

variable "region" {
  type        = string
  default     = "eu-west-1"
  description = "Name of the region"
}

variable "domain" {
  type        = string
  default     = "yobubu.devops.codes"
  description = "Domain for Cloudfront Frontend"
}

variable "api_image" {
  type        = string
  default     = "141917287833.dkr.ecr.eu-west-1.amazonaws.com/react-shop-shared-eu-west-1-api:9-c2967aa"
  description = "name of ECR image for Api"
}