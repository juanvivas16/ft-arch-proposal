variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "assume_role_policy" {
  description = "The role policy variables"
  type = object({
    Version = string
    Statement = list(object({
      Action = string
      Effect = string
      Principal = object({
        Service = string
      })
    }))
  })
}

variable "policy" {
  description = "Policy definition por iam role"
  type = object({
    Version = string
    Statement = list(object({
      Effect   = string
      Action   = list(string)
      Resource = list(string)
    }))
  })
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "stg"
}