variable "sg_alb_name" {
  description = "The name of the ALB security group"
  type        = string
  default     = "tf-ft-alb-sg"
}

variable "sg_alb_description" {
  description = "The description of the ALB security group"
  type        = string
  default     = "Allow web traffic to ALB"
}

variable "sg_alb_ingress_rules" {
  description = "The ingress rules of the ALB security group"
  type        = map(any)
  default = {
    http = {
      from_port                    = 80
      to_port                      = 80
      ip_protocol                  = "tcp"
      cidr_ipv4                    = "0.0.0.0/0"
      referenced_security_group_id = ""
    },
    https = {
      from_port                    = 443
      to_port                      = 443
      ip_protocol                  = "tcp"
      cidr_ipv4                    = "0.0.0.0/0"
      referenced_security_group_id = ""
    }
  }
}

variable "sg_alb_egress_rules" {
  description = "The egress rules of the ALB security group"
  type        = map(any)
  default = {
    all_outbound = {
      from_port   = 0
      to_port     = 0
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
}

variable "sg_ec2_name" {
  description = "The name of the EC2 security group"
  type        = string
  default     = "tf-ft-ec2-sg"
}

variable "sg_ec2_description" {
  description = "The description of the EC2 security group"
  type        = string
  default     = "Allow web traffic from ALB to EC2"
}

variable "sg_ec2_ingress_rules" {
  description = "The ingress rules of the EC2 security group"
  type        = map(any)
  default = {
    http_port   = 80
    https_port  = 443
    ip_protocol = "tcp"
  }
}

variable "sg_ec2_ingress_ssh_rules" {
  description = "The ingress rules of the EC2 security group"
  type        = map(any)
  default = {
    ssh_port    = 22
    ip_protocol = "tcp"
  }
}

variable "sg_ec2_egress_rules" {
  description = "The egress rules of the EC2 security group"
  type        = map(any)
  default = {
    all_outbound = {
      from_port   = 0
      to_port     = 0
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    },
    rds1_outbound = {
      from_port   = 5432
      to_port     = 5432
      ip_protocol = "tcp"
      cidr_ipv4   = "10.0.3.0/24"
    },
    rds2_outbound = {
      from_port   = 5432
      to_port     = 5432
      ip_protocol = "tcp"
      cidr_ipv4   = "10.0.4.0/24"
    }
  }
}

variable "sg_rds_name" {
  description = "The name of the RDS security group"
  type        = string
  default     = "tf-ft-rds-sg"
}

variable "sg_rds_description" {
  description = "The description of the RDS security group"
  type        = string
  default     = "Allow traffic from EC2 to RDS"
}

variable "sg_rds_ingress_rules" {
  description = "The ingress rules of the RDS security group"
  type        = map(any)
  default = {
    postgres_port = 5432
    ip_protocol   = "tcp"
  }
}

variable "sg_rds_egress_rules" {
  description = "The egress rules of the RDS security group"
  type        = map(any)
  default = {
    all_outbound = {
      from_port   = 0
      to_port     = 0
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
}

variable "local_public_ip" {
  description = "The local public IP"
  type        = string
}