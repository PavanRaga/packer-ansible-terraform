terraform {
  backend "s3" {
    bucket = "pavanraga-pavan"
    key    = "packer-ansible-terraform"
    region = "us-east-1"
  }
}
