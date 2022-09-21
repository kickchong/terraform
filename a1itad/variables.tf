data "aws_availability_zones" "westzone" {
    provider = aws.us-west

}
data "aws_availability_zones" "eastzone" {
    provider = aws.us-east
}

variable "domain_password" {
  description = "Domain Password"
  type        = string
}

variable "domain_name" {
  description = "Domain Name"
  type        = string
}

variable "condfwdip" {
  description = "Conditional Forward IP for local R53 zone"
  type        = string
}

variable "dnszone" {
  description = "Local 53 DNS domain name"
  type        = string
}

