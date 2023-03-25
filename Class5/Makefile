bo:
	terraform  apply   -var-file envs/regions/us-east-2/ohio.tfvars --auto-approve

do:
	terraform  destroy   -var-file envs/regions/us-east-2/ohio.tfvars --auto-approve

ireland:
	terraform  apply   -var-file envs/regions/eu-west-1/ireland.tfvars --auto-approve

all: 
	terraform  apply   -var-file envs/regions/us-east-2/ohio.tfvars --auto-approve
	terraform  apply   -var-file envs/regions/eu-west-1/ireland.tfvars --auto-approve


clean:
	find /  -type f  -name "*.log" -exec gzip -v9 {} \; 