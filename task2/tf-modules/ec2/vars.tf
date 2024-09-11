variable "instance_type" {
  description = "Instance type to be used for EC2 instances"
  type        = string
}

variable "public_subnets_ids" {
  description = "List of public subnet IDs where the EC2 instances will be launched"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group ID for the EC2 instances"
  type        = string
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
  default     = 5
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "user_data_file_path" {
  description = "User data script to run when launching the EC2 instances"
  type        = string
  default     = ""
}

variable "target_group_arn" {
  description = "The ARN of the target group for the ALB"
  type        = string
}

variable "instance_name" {
  description = "Tag name for the EC2 instances"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile for the EC2 instance (optional)"
  type        = string
  default     = ""
}

variable "metrics_granularity" {
  description = "Granularity of the metrics (1Minute, 5Minutes, 1Hour)"
  type        = string
  default     = "1Minute"
}

variable "enabled_metrics" {
  description = "List of enabled metrics"
  type        = list(string)
}

variable "scale_up" {
  description = "Auto Scaling Policy variables"
  type = object({
    scaling_adjustment = number
    adjustment_type    = string
    cooldown           = number
  })
}

variable "scale_down" {
  description = "Auto Scaling Policy variables"
  type = object({
    scaling_adjustment = number
    adjustment_type    = string
    cooldown           = number
  })
}

variable "cpu_alarm_up" {
  description = "Cloudwatch cpu alarm up values"
  type        = map(any)
  default = {
    comparison_operator = "GreaterThanOrEqualToThreshold"
    threshold           = 60
    alarm_description   = "This metric monitors ec2 cpu utilization when CPU is high"
    evaluation_periods  = 2
    metric_name         = "CPUUtilization"
    period              = 120
    statistic           = "Average"
  }
}

variable "cpu_alarm_down" {
  description = "Cloudwatch cpu alarm down values"
  type        = map(any)
  default = {
    comparison_operator = "LessThanOrEqualToThreshold"
    threshold           = 10
    alarm_description   = "This metric monitors ec2 cpu utilization when CPU is low"
    evaluation_periods  = 2
    metric_name         = "CPUUtilization"
    period              = 120
    statistic           = "Average"
  }
}

variable "key_name" {
  description = "The name of the key pair"
  type        = string
}
