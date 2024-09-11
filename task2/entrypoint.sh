#!/bin/sh

terraform "$@"

if [ $# -eq 0 ]; then
  echo "no terraform command provided. exiting..."
  exit 1
fi

command=$1
base_path=/app/tf-code/$ENV

case $1 in
    "init")
        cd $base_path && terraform init
        ;;
    "validate")
        cd $base_path && terraform validate
        ;;
    "plan")
        cd $base_path && terraform plan
        ;;
    "apply")
        cd $base_path && terraform apply -auto-approve
        ;;
    "destroy")
        cd $base_path && terraform destroy -auto-approve
        ;;
    *)
        echo "invalid command. available commands: init, validate, plan, apply, destroy."
        ;;
esac
