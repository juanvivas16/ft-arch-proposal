variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "tf-ft-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "vpc_enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "vpc_public_subnets" {
  description = "Map of public subnets"
  type        = map(any)
  default = {
    "0" = { cidr = "10.0.1.0/24", az = "us-east-1a" }
    "1" = { cidr = "10.0.2.0/24", az = "us-east-1b" }
  }
}

variable "vpc_private_subnets" {
  description = "Map of private subnets"
  type        = map(any)
  default = {
    "0" = { cidr = "10.0.3.0/24", az = "us-east-1a" }
    "1" = { cidr = "10.0.4.0/24", az = "us-east-1b" }
  }
}

variable "public_nacl_egress" {
  description = "Network ACL egress rules"
  default = {
    "rule_no"    = "100"
    "protocol"   = "tcp"
    "action"     = "allow"
    "cidr_block" = "0.0.0.0/0"
    "from_port"  = "80"
    "to_port"    = "80"
  }
}

variable "public_nacl_ingress" {
  description = "Network ACL ingress rules"
  default = {
    "rule_no"    = "100"
    "protocol"   = "tcp"
    "action"     = "allow"
    "cidr_block" = "0.0.0.0/0"
    "from_port"  = "80"
    "to_port"    = "80"
  }
}
