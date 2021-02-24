variable "codedeploy_backend_compute_platform" {
  default = "Server"
  type    = string
}

variable "codedeploy_backend_deployment_config_name" {
  default = "CodeDeployDefault.HalfAtATime"
  type    = string
}

variable "codedeploy_backend_deployment_option" {
  default = "WITH_TRAFFIC_CONTROL"
  type    = string
}

variable "codedeploy_backend_deployment_type" {
  default = "IN_PLACE"
  type    = string
}