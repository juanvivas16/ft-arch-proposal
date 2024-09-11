variable "iam_role_name" {
  description = "The name of the IAM role"
  type        = string
  default     = "tf-ft-ec2-role"
}

variable "iam_assume_role_policy" {
  description = "The policy that grants an entity permission to assume the role"
  type        = any
  default = {
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  }
}

variable "iam_policy" {
  description = "The policy that grants an entity permission to assume the role"
  type        = any
  default     = ""
}
