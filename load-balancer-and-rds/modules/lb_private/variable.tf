variable "project_name_prefix" {
  type = string
  description = ""
}

variable "vpc_id" {
  type = string
  description = ""
}

variable "private_subnets" {
  type = any
  description = ""
}

variable "my_ip_cidr" {
  type = any
  description = ""
}

variable "enable_deletion_protection" {
  type = bool
  description = ""
  default = false
}

variable "internal_alb_lc_instance_type" {
  type = string
  description = ""
}

variable "internal_alb_lc_root_volume" {
  type = number
  description = ""
}

variable "key_pair_name" {
  type = string
  description = ""
}

variable "internal_alb_asg_max_size" {
  type = number
  description = ""
}

variable "internal_alb_asg_min_size" {
  type = number
  description = ""
}

variable "internal_alb_asg_desried_size" {
  type = number
  description = ""
}

variable "user_data" {
  type = any
  description = ""
}