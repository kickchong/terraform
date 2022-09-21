resource "tfe_workspace" "a1_infrastructure_ad" {
  name              = "a1_Infrastructure_AD"
  organization      = "albertchong"
  execution_mode    = "remote"
  working_directory = "a1itad"
  auto_apply        = "false"
  queue_all_runs    = "false"
  tag_names         = ["account:a1", "ad"]
  vcs_repo {
    identifier     = "kickchong/terraform"
    branch         = "a1itad"
    oauth_token_id = data.aws_ssm_parameters_by_path.tf_common_wsmgmt.values[index(data.aws_ssm_parameters_by_path.tf_common_wsmgmt.names,"${var.ssmpath}/common/oauth_token_id")]
 
  }
}

resource "tfe_variable" "a1_ad_aws_access_key" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = data.aws_ssm_parameters_by_path.tf_common_wsmgmt.values[index(data.aws_ssm_parameters_by_path.tf_common_wsmgmt.names, "${var.ssmpath}/common/a1_access_key")]  
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.a1_infrastructure_ad.id
  description  = "Access Key used by Terraform Code"
}

resource "tfe_variable" "a1_ad_secret_key" {
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = data.aws_ssm_parameters_by_path.tf_common_wsmgmt.values[index(data.aws_ssm_parameters_by_path.tf_common_wsmgmt.names, "${var.ssmpath}/common/a1_secret_key")]
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.a1_infrastructure_ad.id
  description  = "Secret Key used by Terraform Code"
}

## Create Space for AD
variable "ad_domain" {
  default = {
    addomain  = "a1.aws.local"
    condfwdip = "10.64.0.2"
    dnszone   = "a1.aws.local"
  }
}

variable "domain_password" {
  description = "Environment Variable for example dev02, stage02, prod02"
  type        = string
}

resource "tfe_variable" "infrastructure_ad_domain_name" {
  key          = "domain_name"
  value        = var.ad_domain.addomain
  category     = "terraform"
  workspace_id = tfe_workspace.a1_infrastructure_ad.id
  description  = "Domain Name for Directory Service"
}

resource "tfe_variable" "infrastructure_ad_domain_password" {
  key          = "domain_password"
  value        = var.domain_password
  category     = "terraform"
  sensitive    = true
  workspace_id = tfe_workspace.a1_infrastructure_ad.id
  description  = "Domain Password for Directory Service"
}

resource "tfe_variable" "infrastructure_ad_domain_cndfwdip" {
  key          = "condfwdip"
  value        = var.ad_domain.condfwdip
  category     = "terraform"
  workspace_id = tfe_workspace.a1_infrastructure_ad.id
  description  = "Domain Name for Directory Service"
}

resource "tfe_variable" "infrastructure_ad_domain_dnszone" {
  key          = "dnszone"
  value        = var.ad_domain.dnszone
  category     = "terraform"
  workspace_id = tfe_workspace.a1_infrastructure_ad.id
  description  = "Domain Name for Directory Service"
}
