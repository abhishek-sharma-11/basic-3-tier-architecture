module "bastion_host" {
  source = "./modules/bastion_host"

  project_name_prefix   = var.project_name_prefix
  vpc_id                = var.vpc_id
  public_subnets        = var.public_subnets
  my_ip_cidr            = var.my_ip_cidr

  bastion_instance_type = var.bastion_instance_type
  bastion_az            = var.bastion_az
  bastion_name          = var.bastion_name

}

module "load_balancer_private" {
  source = "./modules/lb_private"

  project_name_prefix           = var.project_name_prefix
  vpc_id                        = var.vpc_id
  private_subnets               = var.private_subnets
  my_ip_cidr                    = var.my_ip_cidr

  enable_deletion_protection    = var.enable_deletion_protection
  internal_alb_lc_instance_type = var.internal_alb_lc_instance_type
  internal_alb_lc_root_volume   = var.internal_alb_lc_root_volume
  key_pair_name                 = var.key_pair_name

  internal_alb_asg_max_size     = var.internal_alb_asg_max_size
  internal_alb_asg_min_size     = var.internal_alb_asg_min_size
  internal_alb_asg_desried_size = var.internal_alb_asg_desried_size
}

module "load_balancer_public" {
  source = "./modules/lb_public"

  project_name_prefix = var.project_name_prefix
  vpc_id              = var.vpc_id
  user_data           = file("nginx-user-data.sh")
  public_subnets      = var.public_subnets
  my_ip_cidr          = var.my_ip_cidr

  enable_deletion_protection  = var.enable_deletion_protection
  external_alb_lc_instance_type = var.external_alb_lc_instance_type
  external_alb_lc_root_volume  = var.external_alb_lc_root_volume
  key_pair_name                 = var.key_pair_name

  external_alb_asg_max_size = var.external_alb_asg_max_size
  external_alb_asg_min_size = var.external_alb_asg_min_size
  external_alb_asg_desired_size =var.external_alb_asg_desired_size
}

module "postgres" {
  source = "./modules/postgres"

  project_name_prefix = var.project_name_prefix
  vpc_id              = var.vpc_id
  private_subnets     = var.private_subnets
}
