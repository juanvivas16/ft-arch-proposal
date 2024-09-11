variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "The environment for the bucket (e.g., dev, prod)"
  type        = string
}
