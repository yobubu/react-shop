/*
  Instance type
*/
data "aws_ami" "amzn2" {

  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

/*
  User data
*/
data "template_file" "init" {
  template = file("${path.module}/templates/init.tpl")
}

/*
  Data from other modules
*/
data "terraform_remote_state" "network_remote_state" {
  backend = "s3"

  config = {
    bucket = "${var.project}-infrastructure"
    key    = "terraform/network/terraform.tfstate"
    region = var.region
  }
}