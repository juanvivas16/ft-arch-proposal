# Data block to fetch the latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# Launch Configuration
resource "aws_launch_configuration" "ec2_lc" {
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  security_groups = [var.security_group_id]
  user_data       = var.user_data_file_path
  key_name        = var.key_name

  lifecycle {
    create_before_destroy = true
  }

  iam_instance_profile = var.iam_instance_profile
}

# Auto Scaling Group
resource "aws_autoscaling_group" "ec2_asg" {
  launch_configuration      = aws_launch_configuration.ec2_lc.id
  vpc_zone_identifier       = var.public_subnets_ids
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  health_check_type         = "EC2"
  health_check_grace_period = 300
  target_group_arns         = [var.target_group_arn]

  metrics_granularity = var.metrics_granularity
  enabled_metrics     = var.enabled_metrics

  tag {
    key                 = "name"
    value               = var.instance_name
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling Policy based on CPU usage
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${var.instance_name}-scale-up-policy"
  scaling_adjustment     = var.scale_up["scaling_adjustment"]
  adjustment_type        = var.scale_up["adjustment_type"]
  cooldown               = var.scale_up["cooldown"]
  autoscaling_group_name = aws_autoscaling_group.ec2_asg.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${var.instance_name}-scale-up-policy"
  scaling_adjustment     = var.scale_up["scaling_adjustment"]
  adjustment_type        = var.scale_up["adjustment_type"]
  cooldown               = var.scale_up["cooldown"]
  autoscaling_group_name = aws_autoscaling_group.ec2_asg.name
}


resource "aws_cloudwatch_metric_alarm" "cpu_alarm_up" {
  alarm_name          = "${var.instance_name}-cpu-alarm-up"
  comparison_operator = var.cpu_alarm_up["comparison_operator"]
  evaluation_periods  = var.cpu_alarm_up["evaluation_periods"]
  metric_name         = var.cpu_alarm_up["metric_name"]
  namespace           = "AWS/EC2"
  period              = var.cpu_alarm_up["period"]
  statistic           = var.cpu_alarm_up["statistic"]
  threshold           = var.cpu_alarm_up["threshold"]
  alarm_description   = var.cpu_alarm_up["alarm_description"]
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ec2_asg.name
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_down" {
  alarm_name          = "${var.instance_name}-cpu-alarm-down"
  comparison_operator = var.cpu_alarm_down["comparison_operator"]
  evaluation_periods  = var.cpu_alarm_down["evaluation_periods"]
  metric_name         = var.cpu_alarm_down["metric_name"]
  namespace           = "AWS/EC2"
  period              = var.cpu_alarm_down["period"]
  statistic           = var.cpu_alarm_down["statistic"]
  threshold           = var.cpu_alarm_down["threshold"]
  alarm_description   = var.cpu_alarm_down["alarm_description"]
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ec2_asg.name
  }
}
