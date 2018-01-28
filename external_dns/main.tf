provider "aws" {
  region      = "eu-west-1"
<<<<<<< HEAD
  profile     = "slalom"
=======
  profile     = "default"
>>>>>>> 690901a2b0356dfdae2376b0167b380ea62f5317
}

terraform {
  backend "s3" {
    bucket = "slalom-k8s-terraform"
    key    = "external_dns/terraform.tfstate"
    region = "eu-west-1"
<<<<<<< HEAD
    profile = "slalom"
=======
    profile = "default"
>>>>>>> 690901a2b0356dfdae2376b0167b380ea62f5317
  }
}
