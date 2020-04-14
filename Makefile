init:
	cd terraform && ssh-keygen -f key && terraform init && cd -
packer-build:
	cd packer && packer build ami-template.json && cd -
terraform plan:
	cd terraform && terraform plan && cd -
terraform apply:
	cd terraform && terraform apply --auto-approve && cd -
terraform destroy:
	cd terraform && terraform destroy && cd -