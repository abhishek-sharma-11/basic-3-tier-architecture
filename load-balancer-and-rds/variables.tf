#----------------------------------------------------
#----------------- Common Variables -----------------
#----------------------------------------------------

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project_name_prefix" {
  type        = string
  default     = "testing"
  description = "A string value to describe project name prefix"
}

variable "common_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
}

variable "vpc_id" {
  type        = string
  description = ""
}

variable "private_subnets" {
  type        = any
  description = ""
}

variable "public_subnets" {
  type        = any
  description = ""
}

variable "my_ip_cidr" {
  type        = any
  description = ""
}

variable "key_pair_name" {
  type        = string
  description = ""
}

#-------------------------------------------------
#----------------- Bastion Hosts -----------------
#-------------------------------------------------

variable "bastion_instance_type" {
  type        = string
  description = ""
}

variable "bastion_az" {
  type        = string
  description = ""
}

variable "bastion_name" {
  type        = string
  description = ""
}

#----------------------------------------------
#----------------- Private LB -----------------
#----------------------------------------------

variable "enable_deletion_protection" {
  type        = bool
  description = ""
  default     = false
}

variable "internal_alb_lc_instance_type" {
  type        = string
  description = ""
}

variable "internal_alb_lc_root_volume" {
  type        = number
  description = ""
}

variable "internal_alb_asg_max_size" {
  type        = number
  description = ""
}

variable "internal_alb_asg_min_size" {
  type        = number
  description = ""
}

variable "internal_alb_asg_desried_size" {
  type        = number
  description = ""
}

variable "tomcat_user_data" {
  type        = string
  description = ""
}

#---------------------------------------------
#----------------- Public LB -----------------
#---------------------------------------------

variable "external_alb_lc_instance_type" {
  type        = string
  description = ""
}

variable "external_alb_lc_root_volume" {
  type        = number
  description = ""
}

variable "external_alb_asg_max_size" {
  type        = number
  description = ""
}

variable "external_alb_asg_min_size" {
  type        = number
  description = ""
}

variable "external_alb_asg_desired_size" {
  type        = number
  description = ""
}

variable "nginx_user_data" {
  type        = string
  description = ""
}


#------------------------------------------------
#----------------- Postgres RDS -----------------
#------------------------------------------------

variable "postgres_allocated_storage" {
  type        = number
  description = ""
}

variable "postgres_max_allocated_storage" {
  type        = number
  description = ""
}

variable "postgres_instance_class" {
  type        = string
  description = ""
}

variable "postgres_db_name" {
  type        = string
  description = ""
}

variable "postgres_db_username" {
  type        = string
  description = ""
}

variable "postgres_db_password" {
  type        = string
  description = ""
}

variable "postgres_db_port" {
  type        = number
  description = ""
}