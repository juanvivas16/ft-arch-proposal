output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.rds.endpoint
}

output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.rds.id
}

output "rds_subnet_group" {
  description = "The subnet group used for RDS"
  value       = aws_db_subnet_group.rds_subnet_group.name
}
