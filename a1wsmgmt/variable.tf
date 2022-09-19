# variable "a1_aws_region" {
#   description = "AWS Region"
#   type        = string
# }

variable "oauth_token" {
  description = "Environment Variable for example dev02, stage02, prod02"
  type        = string
}

variable "ssmpath" {
  type    = string
  default = "/terraform"
}

data "aws_ssm_parameters_by_path" "tf_common_wsmgmt_oauth" {
#  path = "${var.ssmpath}/common/oauth_token_id"
    path = "/terraform/common/abc"
}

