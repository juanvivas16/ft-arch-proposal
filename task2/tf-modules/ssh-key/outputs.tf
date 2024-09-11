output "key_name" {
  description = "ssh key name"
  value       = aws_key_pair.key_pair.key_name
}