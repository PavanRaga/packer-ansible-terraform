# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "mykey"
  public_key = file(var.pub_key_path)
}


resource "aws_instance" "bastion" {
  count = 2
  ami  = var.ami
  instance_type = "t2.micro"
  key_name = aws_key_pair.default.id
  subnet_id = module.vpc.public_subnets[count.index]
  security_groups = [ aws_security_group.public_sg.id ]
  source_dest_check = false
  depends_on = [aws_instance.appserver]
  tags = {
    Name = "bastion server"
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
  # provisioner "local-exec" {
  #   command = "export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook --ssh-common-args '-o ProxyCommand=\"ssh -W ${aws_instance.appserver.private_ip}:22 -q ${var.ssh_user}@${self.public_ip}\"' --private-key ${var.private_key_path} ../ansible/provision.yml"
  # }

}

resource "null_resource" try {
  depends_on = [
    aws_instance.bastion,
    aws_instance.appserver
  ]

  provisioner "local-exec" {
    command = "export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook --ssh-common-args '-o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -W %h:%p -i ${var.private_key_path} -q ${var.ssh_user}@${aws_instance.bastion[0].public_ip}\"' -u ${var.ssh_user} -i '${aws_instance.appserver[0].private_ip},' --private-key ${var.private_key_path} ../ansible/provision.yml"
  }

  provisioner "local-exec" {
    command = "export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook --ssh-common-args '-o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -W %h:%p -i ${var.private_key_path} -q ${var.ssh_user}@${aws_instance.bastion[1].public_ip}\"' -u ${var.ssh_user} -i '${aws_instance.appserver[1].private_ip},' --private-key ${var.private_key_path} ../ansible/provision.yml"
  }
  
}

# Define webserver inside the public subnet
resource "aws_instance" "appserver" {
   count = 2
   ami  = var.ami
   instance_type = "t2.micro"
   key_name = aws_key_pair.default.id
   subnet_id = module.vpc.private_subnets[count.index]
   security_groups = [ aws_security_group.private_sg.id ]
#   associate_public_ip_address = true
   source_dest_check = false
   depends_on = [
     module.vpc
   ]

  tags = {
    Name = "app server"
  }

  # connection {
  #   host = self.public_ip
  #   type = "ssh"
  #   private_key = file(var.private_key_path)
  #   user        = var.ssh_user
  # }

  # Ansible requires Python to be installed on the remote machine as well as the local machine.
  # This also ensures the remote instance is fully up for 'local-exec' execution!
  # provisioner "remote-exec" {
  #   inline = ["echo Connected!"]
  #   #inline = ["sudo apt-get -qq install python -y && sudo apt-get -y update && sudo apt-get install python-pip -y"]
  # }

}

# resource "aws_s3_bucket" "s3" {
#   bucket = "pavan-remote-state-bucket"
#   acl    = "private"
#   force_destroy = true
# }
