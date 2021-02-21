##############################################################################
# Load Balancer
resource "aws_security_group" "loadbalancer" {
  name        = "${var.project}-loadbalancer-sg"
  description = "${var.project} loadbalancer security group"
  vpc_id      = data.terraform_remote_state.network_remote_state.outputs.aws_vpc_id

  ingress {
    from_port   = var.security_group_lb_in_http_from_port
    to_port     = var.security_group_lb_in_http_to_port
    protocol    = var.security_group_lb_in_http_protocol
    cidr_blocks = var.security_group_lb_in_http_cidr
  }

  ingress {
    from_port   = var.security_group_lb_in_https_from_port
    to_port     = var.security_group_lb_in_https_to_port
    protocol    = var.security_group_lb_in_https_protocol
    cidr_blocks = var.security_group_lb_in_https_cidr
  }

  egress {
    from_port   = var.security_group_lb_out_from_port
    to_port     = var.security_group_lb_out_to_port
    protocol    = var.security_group_lb_out_protocol
    cidr_blocks = var.security_group_lb_out_cidr
  }

  tags = {
    Name        = "${var.project}_loadbalancer_sg"
    Project     = var.project
    Environment = var.stage
    Terraform   = true
  }
}

##############################################################################
# Backend behind LB
resource "aws_security_group" "backend_instances_behind_alb" {
  name        = "${var.project}-backend-instances-behind-alb-sg"
  description = "${var.project} backend instances - accept traffic from ALB only - security group"
  vpc_id      = data.terraform_remote_state.network_remote_state.outputs.aws_vpc_id

  ingress {
    from_port       = var.security_group_backend_ec2_in_from_port
    to_port         = var.security_group_backend_ec2_in_to_port
    protocol        = var.security_group_backend_ec2_in_protocol
    security_groups = [aws_security_group.loadbalancer.id]
  }

  ingress {
    from_port = 27017
    to_port   = 27017
    protocol  = "tcp"
    self      = true
  }

  egress {
    from_port   = var.security_group_backend_ec2_out_from_port
    to_port     = var.security_group_backend_ec2_out_to_port
    protocol    = var.security_group_backend_ec2_out_protocol
    cidr_blocks = var.security_group_backend_ec2_out_cidr
  }

  egress {
    from_port = 27017
    to_port   = 27017
    protocol  = "tcp"
    self      = true
  }

  tags = {
    Name        = "${var.project}_backend_instances_behind_alb_sg"
    Project     = var.project
    Environment = var.stage
    Terraform   = true
  }
}
