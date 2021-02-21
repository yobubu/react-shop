variable "custom_bucket_acl" {
  default = "private"
  type    = string
}

variable "custom_bucket_versioning_enabled" {
  default = true
  type    = bool
}

variable "website_bucket_acl" {
  default = "private"
  type    = string
}

variable "website_bucket_versioning_enabled" {
  default = true
  type    = bool
}

variable "website_bucket_website_index" {
  default = "index.html"
  type    = string
}

variable "website_bucket_website_error" {
  default = "error.html"
  type    = string
}