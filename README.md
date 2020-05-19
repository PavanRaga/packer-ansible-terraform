This repo helps in provisioning the infrastructure for a microservice which uploads and retrives file on AWS EC2 using packer, ansible, terraform.

# Pre-requisites:

1) AWS CLI.
2) AWS resource access. configured by "aws configure" with access key id and secret key.
3) Ansible installed
4) Terraform installed.
5) packer installed.

# Deploy instructions:

1) *make init* #This will create required SSH keys
2) *make packer-build* #this will create AMI with required packages. ami-id will be written to terroform directory.
3) *make terrform-apply* # this will provision and deploy the service to ec2.
4) Use "http://public-ip:5000/uploader" to upload file
5) Use "http://serverip:5000/get?file=filename" to retrive file
5) *make terrform-destroy* # this will de-provision the resources.