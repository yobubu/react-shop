terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    template = {
      source = "hashicorp/template"
    }
  }
  required_version = "~> 0.13.5"
}

/*
  https://www.terraform.io/docs/configuration/providers.html#provider-versions
  https://github.com/terraform-providers/terraform-provider-aws/blob/master/CHANGELOG.md
*/
provider "aws" {
  region  = var.region
  version = "~> 3.29.0"
}

provider "aws" {
  alias   = "us-east-1"
  region  = "us-east-1"
  version = "~> 3.29.0"
}

provider "template" {
  version = "~> 2.1"
}

terraform {
  # terraform.backend: configuration cannot contain interpolations
  backend "s3" {
    bucket         = "toptal-task-infrastructure"
    key            = "terraform/staging/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "toptal-task-tf-locks"
  }
}

