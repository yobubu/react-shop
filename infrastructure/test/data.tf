data "terraform_remote_state" "shared_remote_state" {
  backend = "s3"

  config = {
    bucket = "react-shop-yobubu-infrastructure"
    key    = "infrastructure/shared/eu-west-1/terraform.tfstate"
    region = "eu-west-1"
  }
}