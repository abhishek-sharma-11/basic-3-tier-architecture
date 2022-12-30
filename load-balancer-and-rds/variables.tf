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