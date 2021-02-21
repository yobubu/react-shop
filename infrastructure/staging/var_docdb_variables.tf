variable "docdb_master_user" {
  type    = string
  default = "sammy"
}

variable "docdb_master_pass" {
  type    = string
  default = "dummysammy"
}

variable "docdb_backup_retention" {
  type    = number
  default = 5
}

variable "docdb_backup_window" {
  type    = string
  default = "03:00-05:00"
}

variable "docdb_skip_final_snapshot" {
  type    = bool
  default = true
}

variable "docdb_cluster_apply_immediately" {
  type    = bool
  default = true
}

variable "docdb_dluster_instance_count" {
  type    = number
  default = 1
}

variable "docdb_instance_class" {
  type    = string
  default = "db.t3.medium"
}

variable "docdb_instance_apply_immediately" {
  type    = bool
  default = true
}