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

variable "postgres_allocated_storage" {
  type = number
  description = ""
}

variable "postgres_max_allocated_storage" {
  type = number
  description = ""
}

variable "postgres_instance_class" {
  type = string
  description = ""
}

variable "postgres_db_name" {
  type = string
  description = ""
}

variable "postgres_db_username" {
  type = string
  description = ""
}

variable "postgres_db_password" {
  type = string
  description = ""
}

variable "postgres_db_port" {
  type = number
  description = ""
}