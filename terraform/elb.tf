resource "aws_elb" "elb" {
  name               = "internet-elb"
  #availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  subnets = module.vpc.public_subnets
#   access_logs {
#     bucket        = "foo"
#     bucket_prefix = "bar"
#     interval      = 60
#   }
  security_groups = [aws_security_group.public_sg.id]

  listener {
    instance_port     = var.app_port
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

#   listener {
#     instance_port      = 5000
#     instance_protocol  = "http"
#     lb_port            = 443
#     lb_protocol        = "https"
#     # ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
#   }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:${var.app_port}/health"
    interval            = 30
  }

  instances                   = aws_instance.appserver[*].id
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "foobar-terraform-elb"
  }
}