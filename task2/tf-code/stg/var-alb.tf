variable "alb_name" {
  description = "The name of the ALB"
  type        = string
  default     = "tf-ft-alb"
}

variable "alb_target_group_name" {
  description = "The name of the ALB target group"
  type        = string
  default     = "tf-ft-target-group"
}

variable "alb_is_internal" {
  description = "Whether the ALB is internal or not"
  type        = bool
  default     = false
}

variable "alb_health_check_path" {
  description = "The health check path"
  type        = string
  default     = "/health"
}

variable "alb_load_balancing_cross_zone_enabled" {
  description = "Whether to enable cross-zone load balancing"
  type        = bool
  default     = false
}
