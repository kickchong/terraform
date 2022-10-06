resource "tfe_workspace" "k1_infrastructure_ad" {
  name              = "k1_Infrastructure_AD"
  organization      = "albertchong"
  execution_mode    = "remote"
  working_directory = "k1itad"
  auto_apply        = "false"
  queue_all_runs    = "false"
  tag_names         = ["account:k1", "ad"]
  vcs_repo {
    identifier     = "kickchong/terraform"
    branch         = "k1itad"
    oauth_token_id = data.aws_ssm_parameters_by_path.tf_common_wsmgmt.values[index(data.aws_ssm_parameters_by_path.tf_common_wsmgmt.names,"${var.ssmpath}/common/oauth_token_id")]
  }
}

resource "tfe_variable" "k1_ad_aws_access_key" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = data.aws_ssm_parameters_by_path.tf_common_wsmgmt.values[index(data.aws_ssm_parameters_by_path.tf_common_wsmgmt.names, "${var.ssmpath}/common/k1_access_key")]  
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.k1_infrastructure_ad.id
  description  = "Access Key used by Terraform Code"
}

resource "tfe_variable" "k1_ad_secret_key" {
  key          = "AWS_SECRET_ACCESS_KEY"
  value        = data.aws_ssm_parameters_by_path.tf_common_wsmgmt.values[index(data.aws_ssm_parameters_by_path.tf_common_wsmgmt.names, "${var.ssmpath}/common/k1_secret_key")]
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.k1_infrastructure_ad.id
  description  = "Secret Key used by Terraform Code"
}

## Create Space for AD
variable "ad_domain_k1" {
  default = {
    addomain  = "k1.chonglife.com"
    condfwdip = "10.128.0.2"
    dnszone   = "k1.chonglife.com"
  }
}

# variable "domain_password" {
#   description = "Environment Variable for example dev02, stage02, prod02"
#   type        = string
# }

resource "tfe_variable" "infrastructure_ad_domain_name_k1" {
  key          = "domain_name"
  value        = var.ad_domain.addomain
  category     = "terraform"
  workspace_id = tfe_workspace.k1_infrastructure_ad.id
  description  = "Domain Name for Directory Service"
}

resource "tfe_variable" "infrastructure_ad_domain_password_k1" {
  key          = "domain_password"
  value        = var.domain_password
  category     = "terraform"
  sensitive    = true
  workspace_id = tfe_workspace.k1_infrastructure_ad.id
  description  = "Domain Password for Directory Service"
}

resource "tfe_variable" "infrastructure_ad_domain_cndfwdip_k1" {
  key          = "condfwdip"
  value        = var.ad_domain.condfwdip
  category     = "terraform"
  workspace_id = tfe_workspace.k1_infrastructure_ad.id
  description  = "Domain Name for Directory Service"
}

resource "tfe_variable" "infrastructure_ad_domain_dnszone_k1" {
  key          = "dnszone"
  value        = var.ad_domain.dnszone
  category     = "terraform"
  workspace_id = tfe_workspace.k1_infrastructure_ad.id
  description  = "Domain Name for Directory Service"
}
