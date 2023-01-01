module "bastion_host" {
  source = "./modules/bastion_host"

  project_name_prefix   = var.project_name_prefix
  vpc_id                = var.vpc_id
  public_subnets        = var.public_subnets
  my_ip_cidr            = var.my_ip_cidr
  key_pair_name         = var.key_pair_name
  bastion_instance_type = var.bastion_instance_type
  bastion_az            = var.bastion_az
  bastion_name          = var.bastion_name
  

}

module "load_balancer_private" {
  source = "./modules/lb_private"

  project_name_prefix           = var.project_name_prefix
  vpc_id                        = var.vpc_id
  user_data                     = file(var.tomcat_user_data)
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

  project_name_prefix           = var.project_name_prefix
  vpc_id                        = var.vpc_id
  user_data                     = file(var.nginx_user_data)
  public_subnets                = var.public_subnets
  my_ip_cidr                    = var.my_ip_cidr

  enable_deletion_protection    = var.enable_deletion_protection
  external_alb_lc_instance_type = var.external_alb_lc_instance_type
  external_alb_lc_root_volume   = var.external_alb_lc_root_volume
  key_pair_name                 = var.key_pair_name

  external_alb_asg_max_size     = var.external_alb_asg_max_size
  external_alb_asg_min_size     = var.external_alb_asg_min_size
  external_alb_asg_desired_size = var.external_alb_asg_desired_size
}

module "postgres" {
  source = "./modules/postgres"

  project_name_prefix            = var.project_name_prefix
  vpc_id                         = var.vpc_id
  private_subnets                = var.private_subnets

  my_ip_cidr                     = var.my_ip_cidr
  postgres_allocated_storage     = var.postgres_allocated_storage
  postgres_max_allocated_storage = var.postgres_max_allocated_storage
  postgres_instance_class        = var.postgres_instance_class

  postgres_db_name               = var.postgres_db_name
  postgres_db_username           = var.postgres_db_username
  postgres_db_password           = var.postgres_db_password
  postgres_db_port               = var.postgres_db_port
}

module "security_group" {
  source = "./modules/security_group"
}