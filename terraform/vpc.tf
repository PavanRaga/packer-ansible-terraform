module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"
  cidr = var.vpc_cidr
  name = "tf-vpc"
  azs = ["us-east-1d","us-east-1b"]
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
  enable_nat_gateway = true
  tags = local.tags
}