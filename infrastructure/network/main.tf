# Main file. It should include providers, terraform configuration and remote data only.
# You need to adjust it before apply!

provider "aws" {
  region  = var.region
  version = "~> 3.29"
}

terraform {
  # terraform.backend: configuration cannot contain interpolations
  backend "s3" {
    bucket         = "toptal-task-infrastructure"
    key            = "terraform/network/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "toptal-task-tf-locks"
  }
}
