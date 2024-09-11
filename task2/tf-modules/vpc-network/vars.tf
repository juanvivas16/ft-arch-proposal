variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Map of public subnets with CIDR and availability zone"
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {
    "0" = { cidr = "10.0.1.0/24", az = "us-east-1a" }
    "1" = { cidr = "10.0.2.0/24", az = "us-east-1b" }
  }
}

variable "private_subnets" {
  description = "Map of private subnets with CIDR and availability zone"
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {
    "0" = { cidr = "10.0.3.0/24", az = "us-east-1a" }
    "1" = { cidr = "10.0.4.0/24", az = "us-east-1b" }
  }
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "stg"
}

variable "enable_dns_support" {
  description = "Enable DNS support"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames"
  type        = bool
  default     = true
}
