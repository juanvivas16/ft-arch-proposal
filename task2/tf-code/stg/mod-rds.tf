module "rds" {
  source = "../../tf-modules/rds"

  db_name                 = var.rds_db_name
  db_username             = var.rds_db_username
  db_password             = var.rds_db_password
  db_engine               = var.rds_db_engine
  db_engine_version       = var.rds_db_engine_version
  allocated_storage       = var.rds_allocated_storage
  instance_class          = var.rds_instance_class
  multi_az                = var.rds_multi_az
  backup_retention_period = var.rds_backup_retention_period
  publicly_accessible     = var.rds_publicly_accessible
  storage_encrypted       = var.rds_storage_encrypted
  skip_final_snapshot     = var.rds_skip_final_snapshot
  private_subnet_ids      = module.vpc.private_subnets_ids
  security_group_id       = module.rds_sg.id
  env                     = var.env
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = module.rds.rds_endpoint
}
