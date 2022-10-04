resource "tfe_workspace" "a1_infrastructure_vpc" {
  for_each = var.accounts
  name              = "${each.value.env}_Infrastructure_VPC"
  organization      = "albertchong"
  execution_mode    = "remote"
  working_directory = "a1itvpc"
  auto_apply        = "false"
  queue_all_runs    = "false"
  tag_names         = ["account:${each.key}", "vpc", "subnet", "sg"] 
  vcs_repo {
    identifier     = "kickchong/terraform"
    branch         = "a1itvpc"
    oauth_token_id = data.aws_ssm_parameters_by_path.tf_common_wsmgmt.values[index(data.aws_ssm_parameters_by_path.tf_common_wsmgmt.names,"${var.ssmpath}/common/oauth_token_id")]
 
  }
}

resource "tfe_variable" "a1_vpc_aws_access_key" {
  for_each     = var.accounts
  key          = "AWS_ACCESS_KEY_ID"
  value        = data.aws_ssm_parameters_by_path.tf_common_wsmgmt.values[index(data.aws_ssm_parameters_by_path.tf_common_wsmgmt.names, "${var.ssmpath}/common/${each.value.env}_access_key")]  
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.a1_infrastructure_vpc.id
  description  = "Access Key used by Terraform Code"
}

resource "tfe_variable" "a1_vpc_secret_key" {
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = data.aws_ssm_parameters_by_path.tf_common_wsmgmt.values[index(data.aws_ssm_parameters_by_path.tf_common_wsmgmt.names, "${var.ssmpath}/common/${each.value.env}_secret_key")]
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.a1_infrastructure_vpc.id
  description  = "Secret Key used by Terraform Code"
}
