# load-balancer-and-rds

## Load Balancer

This Terraform code snippet is used to launch a Load Balancer with required components (Security Group, Target Group, Auto Scaling Group, Launch Configuration)

## Requirements

Before this module can be used on a project, you must ensure that the following pre-requisites are fulfilled:

1. Terraform is [installed](#software-dependencies) on the machine where Terraform is executed.
2. Make sure you had access to launch the resources in aws.


### Software Dependencies
### Terraform
- [Terraform](https://www.terraform.io/downloads.html) 1.0.x



## Install

### Terraform
Be sure you have the correct Terraform version (1.0.x), you can choose the binary here:
- https://releases.hashicorp.com/terraform/

## File structure
The project has the following folders and files:

- /: Root folder
- /main.tf: Main file for this module, contains all the resources to create
- /provider.tf: File which will store the information about provider
- /variables.tf: All the variables for the module
- /output.tf: The outputs of the module
- /README.md: This file
- /locals.tf: All expressions to use in modules
- /terrafrom.tfvars: Varaible files
 
## Usage

## Step 1: Clone the repo
## Step 2: Then perform the following commands in the root folder:

- `terraform init` to get the plugins
- `terraform plan --var-file="terraform.tfvars"` to see the infrastructure plan
- `terraform apply --var-file="terraform.tfvars"` to apply the infrastructure build
- `terraform destroy --var-file="terraform.tfvars"` to destroy the built infrastructure

## Providers
| Name | Version |
|------|---------|
| aws  | 4.5.0 |

## Modules

| Name | Type |
|------|------|
| lb_private  | module |
| lb_public | module |
| postgres | module |

## Common Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region |  | `string` | us-east-1 | yes |
| project_name_prefix |  | `string` | n/a | yes |
| common_tags |  | `map` | n/a | yes |
| vpc_id |  | `string` | n/a | yes |
| private_subnets |  | `list` | n/a | yes |
| public_subnets |  | `list` | n/a | yes |
| my_ip_cidr |  | `list` | n/a | yes |


## Bastion Hosts Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bastion_instance_type |  | `string` | n/a | yes |
| bastion_az |  | `string` | n/a | yes |
| bastion_name |  | `string` | n/a | yes |


## Private Load Balancer Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| internal_alb_lc_instance_type |  | `string` | n/a | yes |
| internal_alb_lc_root_volume |  | `number` | n/a | yes |
| key_pair_name |  | `string` | n/a | yes |
| internal_alb_asg_max_size |  | `number` | n/a | yes |
| internal_alb_asg_min_size |  | `number` | n/a | yes |
| internal_alb_asg_desried_size |  | `number` | n/a | yes |
| enable_deletion_protection |  | `bool` | n/a | no |


## Public Load Balancer Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| external_alb_lc_instance_type |  | `string` | n/a | yes |
| external_alb_lc_root_volume |  | `number` | n/a | yes |
| key_pair_name |  | `string` | n/a | yes |
| external_alb_asg_max_size |  | `number` | n/a | yes |
| external_alb_asg_min_size |  | `number` | n/a | yes |
| external_alb_asg_desried_size |  | `number` | n/a | yes |
| enable_deletion_protection |  | `bool` | n/a | no |


## Postgres RDS Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| postgres_allocated_storage |  | `number` | n/a | yes |
| postgres_max_allocated_storage |  | `number` | n/a | yes |
| postgres_instance_class |  | `string` | n/a | yes |
| postgres_db_name |  | `string` | n/a | yes |
| postgres_db_username |  | `string` | n/a | yes |
| postgres_db_password |  | `string` | n/a | yes |
| postgres_db_port |  | `number` | n/a | yes |