terraform {
  required_version = "~> 0.12"

  backend "s3" {
    encrypt = true
    bucket  = "bgshop-app-dev" #put your unique bucket name here
    key     = "development/bgshop.tfstate"
  }
}