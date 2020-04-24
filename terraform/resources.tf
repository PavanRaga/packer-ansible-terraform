# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "mykey"
  public_key = file(var.pub_key_path)
}

# Define webserver inside the public subnet
resource "aws_instance" "appserver" {
   ami  = var.ami
   instance_type = "t2.micro"
   key_name = aws_key_pair.default.id
   subnet_id = aws_subnet.public-subnet.id
   vpc_security_group_ids = [aws_security_group.sg-app.id]
   associate_public_ip_address = true
   source_dest_check = false

  tags = {
    Name = "web server"
  }

  connection {
    host = self.public_ip
    type = "ssh"
    private_key = file(var.private_key_path)
    user        = var.ssh_user
  }

  # Ansible requires Python to be installed on the remote machine as well as the local machine.
  # This also ensures the remote instance is fully up for 'local-exec' execution!
  provisioner "remote-exec" {
    inline = ["echo Connected!"]
    #inline = ["sudo apt-get -qq install python -y && sudo apt-get -y update && sudo apt-get install python-pip -y"]
  }

  # Bring the container up using CM.
  provisioner "local-exec" {
    command = "export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook -u ${var.ssh_user} -i '${self.public_ip},' --private-key ${var.private_key_path} ../ansible/provision.yml"
  }

}

resource "aws_s3_bucket" "s3" {
  bucket = "pavan-remote-state-bucket"
  acl    = "private"
}
