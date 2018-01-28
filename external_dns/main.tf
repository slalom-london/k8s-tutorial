provider "aws" {
  region      = "eu-west-1"
  profile     = "slalom"
}

terraform {
  backend "s3" {
    bucket = "{your-tf-s3-bucket}"
    key    = "external_dns/terraform.tfstate"
    region = "eu-west-1"
    profile = "kops"
  }
}
