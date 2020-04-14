output "public_ip" {
  value = "http://${aws_instance.appserver.public_ip}"
}
