# Subnet Group for RDS (Ensure it is in private subnets)
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = var.tags
}

# RDS Instance with Multi-AZ support
resource "aws_db_instance" "rds" {
  db_name                 = var.db_name
  allocated_storage       = var.allocated_storage
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  instance_class          = var.instance_class
  username                = var.db_username
  password                = var.db_password
  parameter_group_name    = var.parameter_group_name
  multi_az                = var.multi_az
  publicly_accessible     = var.publicly_accessible
  storage_encrypted       = var.storage_encrypted
  skip_final_snapshot     = var.skip_final_snapshot
  backup_retention_period = var.backup_retention_period
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [var.security_group_id]

  tags = var.tags
}
