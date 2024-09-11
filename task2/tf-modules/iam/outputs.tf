output "role_name" {
  description = "The name of the IAM role assigned to EC2"
  value       = aws_iam_role.iam_role.name
}

output "instance_profile_name" {
  description = "The name of the instance profile assigned to EC2"
  value       = aws_iam_instance_profile.instance_profile.name
}
