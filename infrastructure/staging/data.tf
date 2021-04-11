data "terraform_remote_state" "network_remote_state" {
  backend = "s3"

  config = {
    bucket = "${var.project}-infrastructure"
    key    = "terraform/network/terraform.tfstate"
    region = var.region
  }
}