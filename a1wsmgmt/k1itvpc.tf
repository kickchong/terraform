resource "tfe_workspace" "k1_infrastructure_vpc" {
  name              = "k1_Infrastructure_VPC"
  organization      = "albertchong"
  execution_mode    = "remote"
  working_directory = "k1itvpc"
  auto_apply        = "false"
  queue_all_runs    = "false"
  tag_names         = ["account:k1", "vpc", "subnet", "sg"] 
  vcs_repo {
    identifier     = "kickchong/terraform"
    branch         = "k1itvpc"
    oauth_token_id = data.aws_ssm_parameters_by_path.tf_common_wsmgmt.values[index(data.aws_ssm_parameters_by_path.tf_common_wsmgmt.names,"${var.ssmpath}/common/oauth_token_id")]
 
  }
}

resource "tfe_variable" "k1_vpc_aws_access_key" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = data.aws_ssm_parameters_by_path.tf_common_wsmgmt.values[index(data.aws_ssm_parameters_by_path.tf_common_wsmgmt.names, "${var.ssmpath}/common/k1_access_key")]  
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.k1_infrastructure_vpc.id
  description  = "Access Key used by Terraform Code"
}

resource "tfe_variable" "k1_vpc_secret_key" {
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = data.aws_ssm_parameters_by_path.tf_common_wsmgmt.values[index(data.aws_ssm_parameters_by_path.tf_common_wsmgmt.names, "${var.ssmpath}/common/k1_secret_key")]
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.k1_infrastructure_vpc.id
  description  = "Secret Key used by Terraform Code"
}



# resource "tfe_variable" "infrastructure_env" {
#   key          = "env"
#   value        = each.key
#   category     = "terraform"
#   workspace_id = tfe_workspace.a1_infrastructure_vpc.id
#   description  = "Environment variable used by Terraform Code"
# }
