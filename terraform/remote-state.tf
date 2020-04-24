terraform {
  backend "s3" {
    bucket = "pavan-remote-state-bucket"
    key    = "packer-ansible-terraform"
    region = "us-east-1"
  }
}
