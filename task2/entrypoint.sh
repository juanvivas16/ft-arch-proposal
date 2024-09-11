#!/bin/bash

if [ $# -eq 0 ]; then
  echo "No command provided. Exiting..."
  exit 1
fi

command=$1
base_path="/app/tf-code/${ENV}"

if [ -z "$ENV" ]; then
  echo "Environment variable ENV not set. Exiting..."
  exit 1
fi

if [ ! -d "$base_path" ]; then
  echo "Directory $base_path does not exist. Exiting..."
  exit 1
fi

case $command in
    "init")
        cd "$base_path" && terraform init
        ;;
    "validate")
        cd "$base_path" && terraform validate
        ;;
    "plan")
        cd "$base_path" && terraform plan
        ;;
    "apply")
        cd "$base_path" && terraform apply -auto-approve
        ;;
    "destroy")
        cd "$base_path" && terraform destroy -auto-approve
        ;;
    "output")
        cd "$base_path" && terraform output
        ;;
    "sec")
        cd "$base_path" && tfsec .
        ;;
    "test")
        ./test.sh
        ;;
    *)
        echo "Invalid command. Available commands: init, validate, plan, apply, destroy, test, sec."
        exit 1
        ;;
esac
