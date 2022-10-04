data "aws_availability_zones" "westzone" {
    provider = aws.us-west

}
data "aws_availability_zones" "eastzone" {
    provider = aws.us-east
}

variable "env" {
  type = "string"
}

variable "accounts" {
  description = "List of AWS Accounts to target"
  default = {
    "albert" = {
      env           = "a1"
      cidr_block_w  = "10.64.0.0/16"
      cidr_block_e  = "10.65.0.0/16"
      r53branch     = "Infrastructure-Route53"
    },
    "kick" = {
      env           = "k1"
      cidr_block_w  = "10.80.0.0/16"
      cidr_block_e  = "10.81.0.0/16"
      r53branch     = "Infrastructure-Route53"
    }  
  }
}

# variable "domain_password" {
#   description = "Domain Password"
#   type        = string
# }

# variable "domain_name" {
#   description = "Domain Name"
#   type        = string
# }

# variable "condfwdip" {
#   description = "Conditional Forward IP for local R53 zone"
#   type        = string
# }

# variable "dnszone" {
#   description = "Local 53 DNS domain name"
#   type        = string
# }

