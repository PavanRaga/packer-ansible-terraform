variable "aws_region" {
  description = "Region for the VPC"
  default = "us-east-1" #because cheaper!
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/28"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "10.0.0.0/28" #Need only one ip!
}

variable "ami" {
  description = "Amazon Linux AMI"
  # default = "pigeonlab-ami" #"ami-085925f297f89fce1" #bionic!
}

variable "pub_key_path" {
  description = "SSH Public Key path"
  default = "key.pub"
}

variable "private_key_path" {
  description = "SSH Private Key path"
  default = "key"
}

variable "ssh_user" {
  description = "SSH user"
  default = "ubuntu"
}

# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}