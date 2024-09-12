variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "tf-ft-readonly-bucket"
}

variable "s3_force_destroy" {
  description = "Whether to force destroy the S3 bucket"
  type        = bool
  default     = false
}