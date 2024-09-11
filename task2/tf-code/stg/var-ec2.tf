variable "ec2_instance_name" {
  description = "EC2 ASG name"
  type        = string
  default     = "tf-ft-ec2-asg"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.medium"
}

variable "ecs_min_size" {
  description = "ASG EC2 min size"
  type        = number
  default     = 1
}

variable "ecs_max_size" {
  description = "ASG EC2 max size"
  type        = number
  default     = 5
}

variable "ecs_desired_capacity" {
  description = "ASG EC2 desired capacity"
  type        = number
  default     = 2
}

variable "ec2_metrics_granularity" {
  description = "EC2 metrics granularity"
  type        = string
  default     = "1Minute"
}

variable "ec2_enabled_metrics" {
  description = "EC2 enabled metrics"
  type        = list(any)
  default     = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]
}

variable "ec2_scale_up" {
  description = "EC2 scale up"
  type        = map(any)
  default = {
    "scaling_adjustment" = 1
    "adjustment_type"    = "ChangeInCapacity"
    "cooldown"           = 90
  }
}

variable "ec2_scale_down" {
  description = "EC2 scale down"
  type        = map(any)
  default = {
    "scaling_adjustment" = -1
    "adjustment_type"    = "ChangeInCapacity"
    "cooldown"           = 90
  }
}

variable "ec2_cpu_alarm_up" {
  description = "EC2 cpu alarm up"
  type        = map(any)
  default = {
    "comparison_operator" = "GreaterThanOrEqualToThreshold"
    "threshold"           = 60
    "alarm_description"   = "This metric monitors ec2 cpu utilization when CPU is high"
    "evaluation_periods"  = 2
    "metric_name"         = "CPUUtilization"
    "period"              = 120
    "statistic"           = "Average"
  }
}

variable "ec2_cpu_alarm_down" {
  description = "EC2 cpu alarm down"
  type        = map(any)
  default = {
    "comparison_operator" = "LessThanOrEqualToThreshold"
    "threshold"           = 10
    "alarm_description"   = "This metric monitors ec2 cpu utilization when CPU is low"
    "evaluation_periods"  = 2
    "metric_name"         = "CPUUtilization"
    "period"              = 120
    "statistic"           = "Average"
  }
}

variable "key_name" {
  description = "Key name"
  default = "ssh-local-key"
}

variable "ssh_public_key" {
  description = "value of ssh public key path"  
}

variable "user_data_file_path" {
  description = "User data file path"
  default     = "./files/ec2_user_data.sh"
}