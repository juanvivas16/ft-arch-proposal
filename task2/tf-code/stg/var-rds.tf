variable "rds_db_name" {
  description = "The name of the RDS database"
  type        = string
  default     = "tfftdb"
}

variable "rds_db_username" {
  description = "The username for the RDS database"
  type        = string
  default     = "tfdbuser"
}

variable "rds_db_password" {
  description = "The password for the RDS database"
  type        = string
  sensitive   = true
  default     = "K24Y4i3XQFd6Rd8gJn7C78XuFp7UlbTF"
}

variable "rds_db_engine" {
  description = "The engine of the RDS database"
  type        = string
  default     = "postgres"
}

variable "rds_db_engine_version" {
  description = "The engine version of the RDS database"
  type        = string
  default     = "16.4"
}

variable "rds_allocated_storage" {
  description = "The allocated storage in GBs of the RDS database"
  type        = number
  default     = 10
}

variable "rds_instance_class" {
  description = "The instance class of the RDS database"
  type        = string
  default     = "db.t4g.small"
}

variable "rds_multi_az" {
  description = "Whether the RDS database is multi-AZ"
  type        = bool
  default     = true
}

variable "rds_backup_retention_period" {
  description = "The number of days to retain backups for"
  type        = number
  default     = 7
}

variable "rds_publicly_accessible" {
  description = "Whether the RDS database is publicly accessible"
  type        = bool
  default     = false
}

variable "rds_storage_encrypted" {
  description = "Whether the RDS database is encrypted"
  type        = bool
  default     = true
}

variable "rds_skip_final_snapshot" {
  description = "Whether to skip the final snapshot"
  type        = bool
  default     = true
}
