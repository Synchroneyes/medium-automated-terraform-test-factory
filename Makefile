.PHONY: test

deploy:
	cd infrastructure && terraform init && terraform apply -auto-approve

test:
	@echo "Initializing terraform modules..."
	@cd modules/securitygroup && terraform init > /dev/null
	@cd modules/vpc && terraform init > /dev/null
	@echo "Running terraform tests..."
	@cd modules/securitygroup && terraform test && rm -rf .terraform .terraform.lock.hcl
	@cd modules/vpc && terraform test && rm -rf .terraform .terraform.lock.hcl