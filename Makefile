
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)


.PHONY: test
test:
	@echo "Test"


local_dev:
	@docker build -t aws-migration-app .

local_run:
	@docker run -p 8000:8000 -it aws-migration-app 


.PHONY: write_vault
write_vault: ## This will write to Vault
	@vault kv put secret/aws-migration-app/staging POSTGRES_DB="POSTGRES_DB-vault" POSTGRES_USER="POSTGRES_USER-vault" ENVIRONMENT="ENVIRONMENT-vault"

.PHONY: read_vault
read_vault: ## This will write to Vault
	@vault kv get -format=json secret/aws-migration-app/staging |jq .data.data 