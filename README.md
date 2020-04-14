This repo helps in provisen a service to upload and retrive file on AWS EC2.

# Pre-requisites:

1) AWS CLI.
2) AWS resource access. configured by "aws configure" with access key id and secret key.
3) Ansible installed
4) Terraform installed.
5) packer installed.

# Deploy instructions:

1) make init #This will create required SSH keys
2) make packer-build #this will create AMI with required packages. copy ami-id.
3) make terrform-apply # this will provision and deploy the service to ec2. Needs ami-id from packer.
4) make terrform-destroy # this will de-provision the resource.