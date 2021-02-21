variable "alb_http_port" {
  default = 80
  type    = number
}

variable "alb_http_protocol" {
  default = "HTTP"
  type    = string
}

variable "alb_http_default_action_type" {
  default = "redirect"
  type    = string
}

variable "alb_http_redirect_port" {
  default = "443"
  type    = string
}

variable "alb_http_redirect_protocol" {
  default = "HTTPS"
  type    = string
}

variable "alb_http_redirect_status_code" {
  default = "HTTP_301"
  type    = string
}

variable "alb_http_redirect_query" {
  default = "#{query}"
  type    = string
}

variable "alb_https_port" {
  default = 443
  type    = number
}

variable "alb_https_protocol" {
  default = "HTTPS"
  type    = string
}

variable "alb_https_ssl_policy" {
  default = "ELBSecurityPolicy-TLS-1-2-2017-01"
  type    = string
}

variable "alb_https_default_action_type" {
  default = "forward"
  type    = string
}

variable "codedeploy_backend_target_group_port" {
  default = "2370"
  type    = string
}

variable "codedeploy_backend_target_group_protocol" {
  default = "HTTP"
  type    = string
}

variable "codedeploy_backend_target_group_hc_healthy_threshold" {
  default = "2"
  type    = string
}

variable "codedeploy_backend_target_group_hc_unhealthy_threshold" {
  default = "10"
  type    = string
}

variable "codedeploy_backend_target_group_hc_interval" {
  default = "10"
  type    = string
}

variable "codedeploy_backend_target_group_hc_matcher" {
  default = "200"
  type    = string
}

variable "codedeploy_backend_target_group_hc_path" {
  default = "/api"
  type    = string
}

variable "codedeploy_backend_target_group_hc_port" {
  default = "traffic-port"
  type    = string
}

variable "codedeploy_backend_target_group_hc_protocol" {
  default = "HTTP"
  type    = string
}

variable "codedeploy_backend_target_group_hc_timeout" {
  default = "8"
  type    = string
}

variable "codedeploy_backend_target_group_deregistration_delay" {
  default = 10
  type    = number
}