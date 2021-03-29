resource "aws_security_group" "public_sg" {
    name = "public_subnet_sg"
    vpc_id = module.vpc.vpc_id

  dynamic "ingress" {
      iterator = port
      for_each = var.public_subnet_sg_ports
      content {
          description = "ingress to public subnet"
          from_port   = port.value
          to_port     = port.value
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
      }
  }

  dynamic "egress" {
      iterator = port
      for_each = var.public_subnet_sg_ports
      content {
          description = "egress to public subnet"
          from_port   = port.value
          to_port     = port.value
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
      }
  }
}

resource "aws_security_group" "private_sg" {
    name = "private_subnet_sg"
    vpc_id = module.vpc.vpc_id

  dynamic "ingress" {
      iterator = port
      for_each = var.public_subnet_sg_ports
      content {
          description = "ingress to public subnet"
          from_port   = port.value
          to_port     = port.value
          protocol    = "tcp"
          #cidr_blocks = [aws_elb.elb.pul]
          security_groups = [aws_security_group.public_sg.id]
      }
  }

  dynamic "egress" {
      iterator = port
      for_each = var.public_subnet_sg_ports
      content {
          description = "egress to public subnet"
          from_port   = port.value
          to_port     = port.value
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          #security_groups = [aws_security_group.public_sg.id]
      }
  }
}