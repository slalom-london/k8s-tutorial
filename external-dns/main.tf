provider "aws" {
  region      = "eu-west-1"
  profile     = "default"
}

terraform {
  backend "s3" {
    bucket = "slalom-k8s-terraform"
    key    = "external_dns/terraform.tfstate"
    region = "eu-west-1"
    profile = "default"
  }
}
