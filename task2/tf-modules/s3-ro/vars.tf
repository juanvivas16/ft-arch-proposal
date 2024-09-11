variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "stg"
}
