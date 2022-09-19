resource "tfe_workspace" "a1_infrastructure_vpc" {
  name              = "a1_Infrastructure_VPC"
  organization      = "albertchong"
  execution_mode    = "remote"
  working_directory = "a1itvpc"
  auto_apply        = "false"
  queue_all_runs    = "false"
  tag_names         = ["account:a1", "vpc"]
  vcs_repo {
    identifier     = "kickchong/terraform"
    branch         = "a1itvpc"
    oauth_token_id = var.oauth_token
   # oauth_token_id = data.aws_ssm_parameters_by_path.tf_common_wsmgmt_oauth.values
  }
}

# data "aws_ssm_parameter" "a1" {
#     name = "abc"
# }
# output "name" {
#     value =  data.aws_ssm_parameter.a1.value
# }
resource "aws_ssm_parameter" "foo" {
  name  = "foo"
  type  = "String"
  value = "bar"
}

output "adfa" {
    value =  aws_ssm_parameter.foo.value
}


# // Put resources/variables that are common to all workspaces here
# resource "tfe_variable" "stamps06prod01_infrastructure_vpc_region" {
#   key          = "stamps_aws_region"
#   value        = "us-west-1"
#   category     = "terraform"
#   workspace_id = tfe_workspace.stamps06prod01_infrastructure_vpc.id
#   description  = "Region variable used by Terraform Code"
# }

# resource "tfe_variable" "stamps06prod01_infrastructure_vpc_environment" {
#   key          = "environment"
#   value        = "stamps06prod01"
#   category     = "terraform"
#   workspace_id = tfe_workspace.stamps06prod01_infrastructure_vpc.id
#   description  = "Environment variable used by Terraform Code"
# }

# resource "tfe_variable" "stamps06prod01_infrastructure_vpc_aws_access_key" {
#   key          = "AWS_ACCESS_KEY_ID"
#   value        = var.stamps06prod01_access_key
#   category     = "env"
#   sensitive    = true
#   workspace_id = tfe_workspace.stamps06prod01_infrastructure_vpc.id
#   description  = "Access Key used by Terraform Code"
# }

# resource "tfe_variable" "stamps06prod01_infrastructure_vpc_secret_key" {
#   key          = "AWS_SECRET_ACCESS_KEY"
#   value        = var.stamps06prod01_secret_key
#   category     = "env"
#   sensitive    = true
#   workspace_id = tfe_workspace.stamps06prod01_infrastructure_vpc.id
#   description  = "Secret Key used by Terraform Code"
# }

# // Put resources/variables that are unique to this workspace here

# variable "stamps06prod01_vpc_info" {
#   description = "VPC details for each account"
#   default = {
#     "stamps06prod01" = {
#       vpc_cidr_block = "10.107.0.0/16"
#       vpc_name       = "stamps06prod01"
#       billing_entity = "dev-server"
#     }
#   }
# }

# resource "tfe_variable" "stamps06prod01_infrastructure_vpc_cidr_block" {
#   key          = "vpc_cidr_block"
#   value        = var.stamps06prod01_vpc_info.stamps06prod01.vpc_cidr_block
#   category     = "terraform"
#   workspace_id = tfe_workspace.stamps06prod01_infrastructure_vpc.id
#   description  = "vpc_cidr_block variable used by Terraform Code"
# }

# resource "tfe_variable" "stamps06prod01_infrastructure_vpc_name" {
#   key          = "vpc_name"
#   value        = var.stamps06prod01_vpc_info.stamps06prod01.vpc_name
#   category     = "terraform"
#   workspace_id = tfe_workspace.stamps06prod01_infrastructure_vpc.id
#   description  = "vpc_name variable used by Terraform Code"
# }

# resource "tfe_variable" "stamps06prod01_infrastructure_vpc_billing_entity" {
#   key          = "billing_entity"
#   value        = var.stamps06prod01_vpc_info.stamps06prod01.billing_entity
#   category     = "terraform"
#   workspace_id = tfe_workspace.stamps06prod01_infrastructure_vpc.id
#   description  = "Billing Entity used for allocating costs"
# }
