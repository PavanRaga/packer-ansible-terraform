init:
	cd terraform && ssh-keygen -f key && terraform init && cd -
packer-build:
	./scripts/packer-build.sh
terraform-plan:
	cd terraform && terraform plan && cd -
terraform-apply:
	cd terraform && terraform apply --auto-approve && cd -
terraform-destroy:
	cd terraform && terraform destroy && cd -