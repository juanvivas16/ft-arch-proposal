variable "alb_name" {
  description = "The name of the ALB"
  type        = string
}

variable "alb_security_group_id" {
  description = "Security Group ID for the ALB"
  type        = list(string)
}

variable "public_subnets_ids" {
  description = "List of public subnet IDs where the ALB will be launched"
  type        = list(string)
}

variable "target_group_name" {
  description = "The name of the target group for the ALB"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be launched"
  type        = string
}

variable "is_internal" {
  description = "Whether the ALB is internal or not"
  type        = bool
  default     = false
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
}
variable "load_balancing_cross_zone_enabled" {
  description = "Enable cross zone load balancing"
  type        = bool
  default     = false
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "stg"
}
