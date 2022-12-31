region              = "ap-south-1"
project_name_prefix = "chalo-aws"
vpc_id              = "vpc-0cb2272d2afc29dfe"
private_subnets     = ["subnet-0565a5ecd725b7f20", "subnet-0b8f52ec73c7f42dd"]
public_subnets      = ["subnet-014aa7db9e63c7c0a", "subnet-0964d730af54e0d31"]
my_ip_cidr          = ["49.36.238.14/32"]
key_pair_name       = "chalo-demo"

common_tags = {
  "Project"     = "chalo"
  "Environment" = "staging"
}

#-------------------------------------------------
#----------------- Bastion Hosts -----------------
#-------------------------------------------------

bastion_instance_type = "t3.micro"
bastion_az            = "ap-south-1a"
bastion_name          = "Bastion-Host"

#----------------------------------------------
#----------------- Private LB -----------------
#----------------------------------------------

internal_alb_lc_instance_type = "t3.micro"
internal_alb_lc_root_volume   = 10
internal_alb_asg_max_size     = 2
internal_alb_asg_min_size     = 1
internal_alb_asg_desried_size = 2
tomcat_user_data              = "tomcat-user-data.sh"
# enable_deletion_protection = false     --------> Using default value as false. Change to true if required

#---------------------------------------------
#----------------- Public LB -----------------
#---------------------------------------------

external_alb_lc_instance_type = "t3.micro"
external_alb_lc_root_volume   = 10
external_alb_asg_max_size     = 2
external_alb_asg_min_size     = 1
external_alb_asg_desired_size = 2
nginx_user_data               = "nginx-user-data.sh"
# enable_deletion_protection = false     --------> Using default value as false. Change to true if required


#------------------------------------------------
#----------------- Postgres RDS -----------------
#------------------------------------------------

postgres_allocated_storage     = 10
postgres_max_allocated_storage = 30
postgres_instance_class        = "db.t3.micro"
postgres_db_name               = "mydb"
postgres_db_username           = "mydbuser"
postgres_db_password           = "mydbpassword"
postgres_db_port               = 5432
