module "load_balancer_public" {
  source = "./modules/lb_public"

  project_name_prefix = var.project_name_prefix
  vpc_id              = var.vpc_id
  user_data           = file("nginx-user-data.sh")

  public_subnets = var.public_subnets
}


module "load_balancer_private" {
  source = "./modules/lb_private"

  project_name_prefix = var.project_name_prefix
  vpc_id              = var.vpc_id
  private_subnets     = var.private_subnets
}

module "postgres" {
  source = "./modules/postgres"

  project_name_prefix = var.project_name_prefix
  vpc_id              = var.vpc_id
  private_subnets     = var.private_subnets
}

module "bastion_host" {
  source = "./modules/bastion_host"

  project_name_prefix = var.project_name_prefix
  vpc_id              = var.vpc_id
  public_subnets      = var.public_subnets
}