data "aws_availability_zones" "westzone" {
    provider = aws.us-west

}
data "aws_availability_zones" "eastzone" {
    provider = aws.us-east
}

data "aws_vpc" "v21qw1" {
    tags = {
         Name = "v21qw1"
    }  
}

data "aws_subnet" "westwebsub" {
  count = "${length(data.aws_availability_zones.westzone.names)}"       
  tags = {
         Name = "public-${element(data.aws_availability_zones.westzone.names, count.index)}"
    }
  
}

output "t1" {
  value = data.aws_subnet.westwebsub[0].id
  
}

data "aws_security_groups" "admgmt" {
  tags = {
    Owner = "terraform.io"
    Name  = "a1-admgmt-sg"
  }
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

