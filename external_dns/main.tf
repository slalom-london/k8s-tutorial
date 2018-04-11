terraform {
  backend "s3" {
    bucket = "{your-tf-bucket}"
    key    = "externaldns/terraform.tfstate"
    region = "{your-aws-region}"
  }
}
