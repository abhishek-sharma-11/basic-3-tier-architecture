region              = "ap-south-1"
project_name_prefix = "chalo-aws"
vpc_id              = "vpc-0cb2272d2afc29dfe"
private_subnets     = ["subnet-0565a5ecd725b7f20", "subnet-0b8f52ec73c7f42dd"]
public_subnets      = ["subnet-014aa7db9e63c7c0a", "subnet-0964d730af54e0d31"]
my_ip_cidr          = ["49.36.238.14/32"]

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