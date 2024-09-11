# Construir la imagen
build:
	docker compose build

# Inicializar Terraform
init:
	docker compose run --rm --remove-orphans tf init 

# Planificar la infraestructura
validate:
	docker compose run --rm --remove-orphans tf validate 

# Planificar la infraestructura
plan:
	docker compose run --rm --remove-orphans tf plan 

# Aplicar la infraestructura
apply:
	docker compose run --rm --remove-orphans tf apply -auto-approve

# Destruir la infraestructura
destroy:
	docker compose run --rm --remove-orphans tf destroy -auto-approve