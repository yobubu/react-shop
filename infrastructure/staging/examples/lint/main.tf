locals {
  aws_region = "us-east-1"
}

provider "aws" {
  region = local.aws_region
}

module "test" {
  source = "../../"

  project    = "examples-lint-test"
  region     = local.aws_region
  account_id = "0000000"
  domain     = "example.com"
  stage      = "staging"
  secrets = {
    TEST = "test"
  }
}
