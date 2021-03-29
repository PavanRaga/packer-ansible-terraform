output "elb_dns" {
  value = "http://${aws_elb.elb.dns_name}"
}
