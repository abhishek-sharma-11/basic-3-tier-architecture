cidr_block           = "10.0.0.0/16"
enable_dns_support   = true
enable_dns_hostnames = true
region               = "ap-south-1"

subnet = {
  "public-ap-south-1a" = {
    is_public = true
    details = [
      {
        availability_zone = "a"
        cidr_address      = "10.0.0.0/20"
      }
    ]
  }
  "public-ap-south-1b" = {
    is_public = true
    details = [
      {
        availability_zone = "b"
        cidr_address      = "10.0.16.0/20"
      }
    ]
  }
  "private-ap-south-1a" = {
    is_public = false
    details = [
      {
        availability_zone = "a"
        cidr_address      = "10.0.32.0/20"
      }
    ]
  }
  "private-ap-south-1b" = {
    is_public = false
    details = [
      {
        availability_zone = "b"
        cidr_address      = "10.0.48.0/20"
      }
    ]
  }
}

project_name_prefix = "chalo-aws-vertical"

common_tags = {
  Project     = "chalo"
  Environment = "staging"
}