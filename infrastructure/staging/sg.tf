resource "aws_security_group" "alb_allow_http" {
  name        = "allow_alb_http"
  description = "Allow http inbound traffic to load balancer"
  vpc_id      = data.terraform_remote_state.network_remote_state.outputs.aws_vpc_id

  ingress {
    description = "http from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "backend_allow_http" {
  name        = "allow_backend_http"
  description = "Allow http inbound traffic from load balancer to backend"
  vpc_id      = data.terraform_remote_state.network_remote_state.outputs.aws_vpc_id

  ingress {
    description = "http from load balancer"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}