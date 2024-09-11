module "alb" {
  source = "../../tf-modules/alb-http"

  alb_name                          = var.alb_name
  alb_security_group_id             = [module.alb_sg.id]
  public_subnets_ids                = module.vpc.public_subnets_ids
  target_group_name                 = var.alb_target_group_name
  vpc_id                            = module.vpc.vpc_id
  is_internal                       = var.alb_is_internal
  health_check_path                 = var.alb_health_check_path
  load_balancing_cross_zone_enabled = var.alb_load_balancing_cross_zone_enabled
  env                               = var.env
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = module.alb.alb_dns_name
}
