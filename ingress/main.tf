provider "aws" {
  region      = "{your-aws-region}"
}

terraform {
  backend "s3" {
    bucket = "{your-tf-bucket}"
    key    = "ingress/terraform.tfstate"
    region = "{your-aws-region}"
  }
}
