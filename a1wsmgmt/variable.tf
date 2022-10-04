# variable "a1_aws_region" {
#   description = "AWS Region"
#   type        = string
# }

# variable "oauth_token" {
#   description = "Environment Variable for example dev02, stage02, prod02"
#   type        = string
# }


variable "ssmpath" {
  type    = string
  default = "/terraform"
}

data "aws_ssm_parameters_by_path" "tf_common_wsmgmt" {
    path = "${var.ssmpath}/common/"
}

variable "accounts" {
  description = "List of AWS Accounts to target"
  default = {
    "albert" = {
      env = "a1"
      r53branch = "Infrastructure-Route53"
    },
    "kick" = {
      env = "k1"
      r53branch = "Infrastructure-Route53"
    }  
  }
}