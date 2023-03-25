build-ohio:
	terraform workspace new ohio || terraform workspace select ohio  && terraform init &&   terraform  apply   -var-file envs/regions/us-east-2/ohio.tfvars --auto-approve

destroy-ohio:
	terraform  destroy   -var-file envs/regions/us-east-2/ohio.tfvars --auto-approve

build-ireland:
	terraform  apply   -var-file envs/regions/eu-west-1/ireland.tfvars --auto-approve

destroy-ireland:
	terraform  apply   -var-file envs/regions/eu-west-1/ireland.tfvars --auto-approve
