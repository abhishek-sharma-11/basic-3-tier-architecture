#---------------------------------------
#----------------- VPC -----------------
#---------------------------------------

module "vpc_main" {
  source               = "./modules/vpc"
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = merge(var.common_tags, tomap({
    "Name" : var.project_name_prefix
  }))
}

module "subnet_main" {
  depends_on          = [module.vpc_main]
  for_each            = var.subnet
  source              = "./modules/subnets-module"
  vpc_id              = module.vpc_main.vpc_id
  region              = var.region
  name                = each.key
  subnet_details      = each.value.details
  is_public           = each.value.is_public
  common_tags         = var.common_tags
  project_name_prefix = var.project_name_prefix
}

module "internet_gateway" {
  depends_on = [module.vpc_main]
  source     = "./modules/internet-gateway"
  vpc_id     = module.vpc_main.vpc_id
  tags = merge(var.common_tags, tomap({
    "Name" : "${var.project_name_prefix}-internet-gateway"
  }))
}

module "elastic_ip" {
  source = "./modules/elastic-ip"
  tags = merge(var.common_tags, tomap({
    "Name" : "${var.project_name_prefix}-elastic-ip"
  }))
}

module "nat_gateway" {
  depends_on    = [module.subnet_main, module.elastic_ip]
  source        = "./modules/nat-gateway"
  allocation_id = module.elastic_ip.eip_id
  subnet_id     = values(lookup(tomap({ for k, bd in module.subnet_main : k => bd.subnet_id }), local.public_subnet_name, {}))[0]
  tags = merge(var.common_tags, tomap({
    "Name" : "${var.project_name_prefix}-nat-gateway"
  }))
}

module "route_table" {
  depends_on          = [module.vpc_main, module.internet_gateway]
  for_each            = var.subnet
  source              = "./modules/route-table-module"
  vpc_id              = module.vpc_main.vpc_id
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  nat_gateway_id      = module.nat_gateway.nat_gateway_id
  common_tags         = var.common_tags
  project_name_prefix = var.project_name_prefix
  name                = each.key
  is_public           = each.value.is_public
  cidr_block          = "0.0.0.0/0"
}

module "route_table_association" {
  depends_on     = [module.subnet_main, module.route_table]
  for_each       = tomap({ for k, bd in module.subnet_main : k => bd.subnet_id })
  source         = "./modules/route-table-association-module"
  subnet_ids     = each.value
  route_table_id = lookup(tomap({ for k, bd in module.route_table : k => bd.route_table_id }), each.key, "undefined")
}