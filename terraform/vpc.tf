# Define our VPC
resource "aws_vpc" "default" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "fileuploader-app"
  }
}

# Define the public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.default.id
  cidr_block = var.public_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Public Subnet"
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "VPC IGW"
  }
}

# Define the route table
resource "aws_route_table" "app-public-rt" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public Subnet RT"
  }
}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "app-public-rt" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.app-public-rt.id
}

# Define the security group for public subnet
resource "aws_security_group" "sg-app" {
  name = "app_sg"
  description = "Allow incoming HTTP connections & SSH access"

  ingress {
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ingress {
  #   from_port = 443
  #   to_port = 443
  #   protocol = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # Can be removed! This is to test ping
  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # TODO:allow SSH source only from terraform admin?
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  vpc_id=aws_vpc.default.id

  tags = {
    Name = "App Server SG"
  }
}
