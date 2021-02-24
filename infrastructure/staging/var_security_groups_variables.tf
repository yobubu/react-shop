variable "security_group_lb_in_http_from_port" {
  default = 80
  type    = number
}

variable "security_group_lb_in_http_to_port" {
  default = 80
  type    = number
}

variable "security_group_lb_in_http_protocol" {
  default = "tcp"
  type    = string
}

variable "security_group_lb_in_http_cidr" {
  type = list(string)
  default = [
    "0.0.0.0/0",
  ]
}

variable "security_group_lb_in_https_from_port" {
  default = 443
  type    = number
}

variable "security_group_lb_in_https_to_port" {
  default = 443
  type    = number
}

variable "security_group_lb_in_https_protocol" {
  default = "tcp"
  type    = string
}

variable "security_group_lb_in_https_cidr" {
  type = list(string)
  default = [
    "0.0.0.0/0",
  ]
}

variable "security_group_lb_out_from_port" {
  default = 0
  type    = number
}

variable "security_group_lb_out_to_port" {
  default = 0
  type    = number
}

variable "security_group_lb_out_protocol" {
  default = "-1"
  type    = string
}

variable "security_group_lb_out_cidr" {
  type = list(string)
  default = [
    "0.0.0.0/0",
  ]
}

variable "security_group_backend_ec2_in_from_port" {
  default = 2370
  type    = number
}

variable "security_group_backend_ec2_in_to_port" {
  default = 2370
  type    = number
}

variable "security_group_backend_ec2_in_protocol" {
  default = "tcp"
  type    = string
}

variable "security_group_backend_ec2_out_from_port" {
  default = 0
  type    = number
}

variable "security_group_backend_ec2_out_to_port" {
  default = 0
  type    = number
}

variable "security_group_backend_ec2_out_protocol" {
  default = "-1"
  type    = string
}

variable "security_group_backend_ec2_out_cidr" {
  type = list(string)
  default = [
    "0.0.0.0/0",
  ]
}
