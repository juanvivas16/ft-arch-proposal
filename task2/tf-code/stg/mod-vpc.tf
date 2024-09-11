module "vpc" {
  source = "../../tf-modules/vpc-network"

  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  public_subnets       = var.vpc_public_subnets
  private_subnets      = var.vpc_private_subnets
  env                  = var.env
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets_ids" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnets_ids
}

output "private_subnets_ids" {
  description = "The IDs of the private subnets"
  value       = module.vpc.private_subnets_ids
}
