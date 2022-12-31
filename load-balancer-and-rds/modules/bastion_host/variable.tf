variable "project_name_prefix" {
  type = string
  description = ""
}

variable "vpc_id" {
  type = string
  description = ""
}

variable "public_subnets" {
  type = any
  description = ""
}

variable "bastion_instance_type" {
  type = string
  description = ""
}

variable "bastion_az" {
  type = string
  description = ""  
}

variable "bastion_name" {
  type = string
  description = ""  
}

variable "my_ip_cidr" {
  type = any
  description = ""
}

variable "key_pair_name" {
  type = string
  description = ""
}