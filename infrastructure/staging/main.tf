# Main file. It should include providers, terraform configuration and remote data only.
# You need to adjust it before apply!

provider "aws" {
  region  = var.region
  version = "~> 3.36"
}

provider "aws" {
  alias   = "us-east-1"
  region  = "us-east-1"
  version = "~> 3.36.0"
}

terraform {
  required_version = "~> 0.13.5"
  # terraform.backend: configuration cannot contain interpolations
  backend "s3" {
    bucket         = "react-shop-infrastructure"
    key            = "terraform/staging/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "react-shop-tf-locks"
  }
}