locals {
  stack_name = "${var.project}-${var.environment}-${var.region}"
}

terraform {
  backend "s3" {
    bucket         = "react-shop-yobubu-infrastructure"
    key            = "infrastructure/test/eu-west-1/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "react-shop-tf-locks"

  }
}