module "s3_prive_bucket" {
  source = "../../tf-modules/s3-ro"

  bucket_name   = var.s3_bucket_name
  force_destroy = var.s3_force_destroy
  env           = var.env
}

output "s3_domain_name" {
  description = "s3 bucket domain name"
  value       = module.s3_prive_bucket.bucket_domain_name
}
