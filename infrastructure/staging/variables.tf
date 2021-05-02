variable "project" {
  type        = string
  default     = "react-shop"
  description = "Project name eg. react-shop"
}
variable "region" {
  type        = string
  default     = "ap-southeast-1"
  description = "AWS Region"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment eg. dev, qa, uat, prod"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`)"
}

variable "domain" {
  type        = string
  default     = "shop.devops.codes"
  description = "Hosted Zone created in Route 53 to use with ALB & CloudFront"
}

variable "docdb_master_user" {
  type        = string
  default     = "sammysammy"
  description = "User name for AWS Document DB"
}

variable "docdb_master_pass" {
  type        = string
  default     = "dummydummy"
  description = "Password for AWS Document DB"
}

#################
# ECS Application
#################

variable "app_fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  type        = number
  default     = 1024
}

variable "app_fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  type        = number
  default     = 2048
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster to be provided from command line"
  type        = string
  default     = "pawelfraczyk/nodeapi"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to - must match the one in docker settings"
  type        = number
  default     = 2370
}

variable "app_entrypoint" {
  type        = list(string)
  description = "The entry point that is passed to the container"
  default     = null
}

variable "app_command" {
  type        = list(string)
  description = "The command that is passed to the container"
  default     = null
}

variable "cloudwatch_logs_retention" {
  type        = number
  default     = 30
  description = "Retention in days for CloudWatch Log Groups"
}