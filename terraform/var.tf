variable "aws_region" {
  description = "Region for the VPC"
  default = "us-east-1" #because cheaper!
}

variable "app_port" {
  type = string
  default = "8080"
}

variable "public_subnet_sg_ports" {
   type = list(string)
   default = ["443","80","22","8080"]
}

variable "private_subnet_sg_ports" {
   type = list(string)
   default = ["443","80","22","8080"]
}


variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "CIDR for the public subnet"
  default = ["10.0.1.0/24", "10.0.4.0/24"] #Need only one ip!
}

variable "private_subnets" {
  description = "CIDR for the public subnet"
  default = ["10.0.2.0/24", "10.0.3.0/24"] #Need only one ip!
}

# variable "ami" {
#   description = "Amazon Linux AMI"
#   # default = "ami-085925f297f89fce1" #bionic!
# }

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
