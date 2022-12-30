provider "aws" {
  region  = var.region
  profile = "aws-personal"
  default_tags {
    tags = var.common_tags
  }
}
