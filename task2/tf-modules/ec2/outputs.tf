output "autoscaling_group_name" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.ec2_asg.name
}

output "launch_configuration_id" {
  description = "The ID of the EC2 Launch Configuration"
  value       = aws_launch_configuration.ec2_lc.id
}

output "instance_type" {
  description = "The instance type of the EC2 instances"
  value       = aws_launch_configuration.ec2_lc.instance_type
}
