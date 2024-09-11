terraform {
  backend "local" {
    path = "/app/tf-state/stg/terraform.tfstate"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.66.0"
    }
  }
}

provider "aws" {
  # Configuration options
}
