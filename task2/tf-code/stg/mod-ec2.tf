module "ssh_key" {
  source              = "../../tf-modules/ssh-key"
  key_name            = var.key_name
  ssh_public_key = var.ssh_public_key
}

module "ec2_asg" {
  source = "../../tf-modules/ec2"

  instance_name        = var.ec2_instance_name
  instance_type        = var.ec2_instance_type
  public_subnets_ids   = module.vpc.public_subnets_ids
  security_group_id    = module.ec2_sg.id
  target_group_arn     = module.alb.target_group_arn
  min_size             = var.ecs_min_size
  max_size             = var.ecs_max_size
  desired_capacity     = var.ecs_desired_capacity
  iam_instance_profile = module.iam_ec2.instance_profile_name
  user_data_file_path  = file(var.user_data_file_path)
  metrics_granularity  = var.ec2_metrics_granularity
  enabled_metrics      = var.ec2_enabled_metrics
  scale_up             = var.ec2_scale_up
  scale_down           = var.ec2_scale_down
  cpu_alarm_up         = var.ec2_cpu_alarm_up
  cpu_alarm_down       = var.ec2_cpu_alarm_down
  key_name             = module.ssh_key.key_name
}
