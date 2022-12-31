variable "project_name_prefix" {
  type = string
  description = ""
}

variable "vpc_id" {
  type = string
  description = ""
}

variable "user_data" {
  type = any
  description = ""
}

variable "public_subnets" {
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

variable "external_alb_lc_instance_type" {
  type = string
  description = ""
}

variable "external_alb_lc_root_volume" {
  type = number
  description = ""
}

variable "key_pair_name" {
  type = string
  description = ""
}

variable "external_alb_asg_max_size" {
  type = number
  description = ""
}

variable "external_alb_asg_min_size" {
  type = number
  description = ""
}

variable "external_alb_asg_desired_size" {
  type = number
  description = ""
}
