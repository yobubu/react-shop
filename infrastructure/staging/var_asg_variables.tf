variable "ec2_lt_ebs_volume_size" {
  default = 30
  type    = number
}

variable "ec2_lt_monitoring_enabled" {
  default = true
  type    = bool
}

variable "ec2_lt_lifecycle_create_before_destroy" {
  default = true
  type    = bool
}

variable "asg_backend_on_demand_base_capacity" {
  default = 2
  type    = number
}

variable "asg_backend_on_demand_percentage_above_base_capacity" {
  default = 100
  type    = number
}

variable "asg_backend_spot_instance_pools" {
  default = 2
  type    = number
}

variable "asg_backend_override_instance_type" {
  description = "This will override the instance_type parameter in the launch template."
  default     = "t3.micro"
}

variable "asg_backend_enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances"
  type        = list(string)
  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]
}

variable "asg_backend_metrics_granularity" {
  default = "1Minute"
  type    = string
}

variable "asg_backend_health_check_type" {
  description = "Either 'EC2' or 'ELB' -- see https://docs.aws.amazon.com/autoscaling/ec2/userguide/healthcheck.html"
  default     = "EC2"
  type        = string
}

variable "asg_backend_health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  default     = 60
  type        = number
}

variable "asg_backend_max_size" {
  description = "The maximum size of the auto scale group"
  default     = "6"
  type        = string
}

variable "asg_backend_min_size" {
  description = "The minimum size of the auto scale group"
  default     = "2"
  type        = string
}

variable "asg_backend_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  default     = "2"
  type        = string
}

variable "asg_backend_default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start, default: 300"
  default     = 60
  type        = number
}

variable "asg_backend_force_delete" {
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  default     = false
  type        = bool
}

variable "asg_backend_termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default"
  default     = ["Default"]
  type        = list(string)
}

variable "asg_backend_wait_for_capacity_timeout" {
  default = "0"
  type    = string
}

variable "asg_backend_protect_from_scale_in" {
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events."
  default     = false
  type        = bool
}

variable "asg_backend_lifecycle_create_before_destroy" {
  default = true
  type    = bool
}

variable "asg_policy_policy_type" {
  default = "TargetTrackingScaling"
  type    = string
}

variable "asg_policy_estimated_instance_warmup" {
  default = 120
  type    = number
}

variable "asg_policy_predefined_metric_type" {
  default = "ASGAverageCPUUtilization"
  type    = string
}

variable "asg_policy_target_value" {
  default = 75.0
  type    = number
}
