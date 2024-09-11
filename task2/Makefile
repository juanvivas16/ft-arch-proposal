DCOMPOSE=docker compose

# Build the Docker image
build:
	$(DCOMPOSE) build

# Initialize Terraform
init:
	$(DCOMPOSE) run --rm --remove-orphans tf init 

# Validate Terraform configuration
validate:
	$(DCOMPOSE) run --rm --remove-orphans tf validate 

# Plan Terraform infrastructure
plan:
	$(DCOMPOSE) run --rm --remove-orphans tf plan 

# Apply Terraform infrastructure changes
apply:
	$(DCOMPOSE) run --rm --remove-orphans tf apply -auto-approve

# Destroy Terraform infrastructure
destroy:
	$(DCOMPOSE) run --rm --remove-orphans tf destroy -auto-approve

# Test Terraform infrastructure scalability and load balacing
test:
	$(DCOMPOSE) run --rm --remove-orphans tf test

# Stop and clean up orphan containers or unused resources
clean:
	$(DCOMPOSE) down --remove-orphans