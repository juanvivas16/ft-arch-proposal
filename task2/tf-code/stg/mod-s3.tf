module "s3_prive_bucket" {
  source = "../../tf-modules/s3-ro"

  bucket_name = var.s3_bucket_name
  environment = var.env
}

output "s3_domain_name" {
  description = "s3 bucket domain name"
  value       = module.s3_prive_bucket.bucket_domain_name
}
