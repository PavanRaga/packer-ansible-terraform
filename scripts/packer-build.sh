#!/bin/bash

cd packer
packer build -machine-readable ami-template.json | tee output.txt
AMI_ID=`awk -F: '/artifact,0,id/ {print $2}' < output.txt`
echo 'variable "ami" { default = "'${AMI_ID}'" }' > ../terraform/amivar.tf
rm output.txt
cd -
