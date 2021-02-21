variable "account_id" {
  description = "Account number"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "stage" {
  description = "Project stage e.g. staging"
  type        = string
}

variable "region" {
  description = "AWS Region e.g. eu-west-1"
  type        = string
}

variable "domain" {
  description = "Base domain for the project e.g. example.com"
  type        = string
}
variable "secrets" {
  description = "Secrets uploaded to AWS Parameters Store"
  type        = map
}