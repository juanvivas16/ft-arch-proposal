variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_username" {
  description = "The master username for the database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "The master password for the database"
  type        = string
}

variable "allocated_storage" {
  description = "The amount of allocated storage in GBs"
  type        = number
  default     = 20
}

variable "instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "backup_retention_period" {
  description = "The number of days to retain backups for"
  type        = number
  default     = 7
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the RDS instance"
  type        = list(string)
}

variable "security_group_id" {
  description = "The security group ID for the RDS instance"
  type        = string
}

variable "tags" {
  description = "RDS instance tags"
  type        = map(string)
}

variable "db_engine" {
  description = "The database engine to use"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "DB engine version"
  type        = string
  default     = "16.4"
}

variable "parameter_group_name" {
  description = "DB parameter group name"
  type = string
  default = "default.postgres16"
}

variable "multi_az" {
  description = "Enable multi-az deployment"
  type = bool  
}

variable "publicly_accessible" {
  description = "Enable public access to the DB"
  type = bool
}

variable "storage_encrypted" {
  description = "Enable DB encryption"
  type = bool
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot creation"
  type = bool
} 
