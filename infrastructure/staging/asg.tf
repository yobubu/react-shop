/*
  Launch template
*/
resource "aws_launch_template" "ec2_launch_template" {
  name_prefix            = "${var.project}-${var.stage}-asg-lt-"
  vpc_security_group_ids = [aws_security_group.backend_instances_behind_alb.id]
  image_id               = data.aws_ami.amzn2.id

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.ec2_lt_ebs_volume_size
      volume_type = "gp3"
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  monitoring {
    enabled = var.ec2_lt_monitoring_enabled
  }

  user_data = base64encode(data.template_file.init.rendered)

  lifecycle {
    create_before_destroy = true
  }
}

/*
  Auto-scaling group
*/
resource "aws_autoscaling_group" "backend_asg" {
  target_group_arns = flatten([aws_alb_target_group.codedeploy_backend_target_group.*.arn])

  name_prefix         = "${var.project}-${var.stage}-asg-lt-"
  vpc_zone_identifier = flatten([data.terraform_remote_state.network_remote_state.outputs.aws_vpc_private_subnets.*])

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = var.asg_backend_on_demand_base_capacity
      on_demand_percentage_above_base_capacity = var.asg_backend_on_demand_percentage_above_base_capacity
      spot_instance_pools                      = var.asg_backend_spot_instance_pools
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.ec2_launch_template.id
        version            = aws_launch_template.ec2_launch_template.latest_version
      }

      override {
        instance_type = var.asg_backend_override_instance_type
      }
    }
  }

  enabled_metrics           = var.asg_backend_enabled_metrics
  metrics_granularity       = var.asg_backend_metrics_granularity
  health_check_type         = var.asg_backend_health_check_type
  health_check_grace_period = var.asg_backend_health_check_grace_period
  max_size                  = var.asg_backend_max_size
  min_size                  = var.asg_backend_min_size
  desired_capacity          = var.asg_backend_desired_capacity
  default_cooldown          = var.asg_backend_default_cooldown
  force_delete              = var.asg_backend_force_delete
  termination_policies      = var.asg_backend_termination_policies
  wait_for_capacity_timeout = var.asg_backend_wait_for_capacity_timeout
  protect_from_scale_in     = var.asg_backend_protect_from_scale_in

  tags = [
    {
      key                 = "SSM Target Tag"
      value               = "tagged"
      propagate_at_launch = true
    },
    {
      key                 = "Name"
      value               = "${var.project}-${var.stage}-asg-lt"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = var.project
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = var.stage
      propagate_at_launch = true
    },
    {
      key                 = "Terraform"
      value               = true
      propagate_at_launch = true
    },
  ]

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_launch_template.ec2_launch_template]
}

resource "aws_autoscaling_policy" "asg_policy" {
  name                      = "${var.project}-target-scaling-policy-based-on-avg-cpu-util"
  autoscaling_group_name    = aws_autoscaling_group.backend_asg.name
  policy_type               = var.asg_policy_policy_type
  estimated_instance_warmup = var.asg_policy_estimated_instance_warmup
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.asg_policy_predefined_metric_type
    }
    target_value = var.asg_policy_target_value
  }
}
