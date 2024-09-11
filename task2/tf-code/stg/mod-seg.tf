module "alb_sg" {
  source = "../../tf-modules/seg"

  sg_name        = var.sg_alb_name
  sg_description = var.sg_alb_description
  vpc_id         = module.vpc.vpc_id
  ingress_rules  = var.sg_alb_ingress_rules
  egress_rules   = var.sg_alb_egress_rules
}

module "ec2_sg" {
  source = "../../tf-modules/seg"

  sg_name        = var.sg_ec2_name
  sg_description = var.sg_ec2_description
  vpc_id         = module.vpc.vpc_id
  egress_rules   = var.sg_ec2_egress_rules

  ingress_rules = {
    http_from_alb = {
      from_port                    = var.sg_ec2_ingress_rules["http_port"]
      to_port                      = var.sg_ec2_ingress_rules["http_port"]
      ip_protocol                  = var.sg_ec2_ingress_rules["ip_protocol"]
      cidr_ipv4                    = ""
      referenced_security_group_id = module.alb_sg.id
    },
    https_from_alb = {
      from_port                    = var.sg_ec2_ingress_rules["https_port"]
      to_port                      = var.sg_ec2_ingress_rules["https_port"]
      ip_protocol                  = var.sg_ec2_ingress_rules["ip_protocol"]
      cidr_ipv4                    = ""
      referenced_security_group_id = module.alb_sg.id
    },
    ssh_from_local = {
      from_port                    = var.sg_ec2_ingress_ssh_rules["ssh_port"]
      to_port                      = var.sg_ec2_ingress_ssh_rules["ssh_port"]
      ip_protocol                  = var.sg_ec2_ingress_ssh_rules["ip_protocol"]
      cidr_ipv4                    = var.local_public_ip
      referenced_security_group_id = ""
    }
  }
}

module "rds_sg" {
  source         = "../../tf-modules/seg"
  sg_name        = var.sg_rds_name
  sg_description = var.sg_rds_description
  vpc_id         = module.vpc.vpc_id
  egress_rules   = var.sg_rds_egress_rules
  ingress_rules = {
    postgres_from_ec2 = {
      from_port                    = var.sg_rds_ingress_rules["postgres_port"]
      to_port                      = var.sg_rds_ingress_rules["postgres_port"]
      ip_protocol                  = var.sg_rds_ingress_rules["ip_protocol"]
      cidr_ipv4                    = ""
      referenced_security_group_id = module.ec2_sg.id
    }
  }
}
