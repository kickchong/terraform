resource "aws_directory_service_directory" "a1" {
  name        = var.domain_name
  password    = var.domain_password
  type        = "SimpleAD"
  size        = "Small"
  description = "Managed by terraform.io"
  vpc_settings {
    vpc_id     = data.aws_vpc.v21qw1.id
    subnet_ids = [data.aws_subnet.westwebsub[0].id,data.aws_subnet.westwebsub[1].id]

  }
}

#NTP Servers are pointing to US National Institute of Standards and Technology: time-a-g.nist.gov
resource "aws_vpc_dhcp_options" "this" {
  domain_name          = var.domain_name
  domain_name_servers  = aws_directory_service_directory.a1.dns_ip_addresses
  ntp_servers          = ["129.6.15.28","129.6.15.29"]

  tags = {
    Name        = var.domain_name
    description =  "Managed by terraform.io"
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = data.aws_vpc.v21qw1.id
  dhcp_options_id = aws_vpc_dhcp_options.this.id
}

# resource "aws_directory_service_conditional_forwarder" "a1_aws_local" {
#   directory_id        = aws_directory_service_directory.a1.id
#   remote_domain_name  = var.dnszone

#   dns_ips = [
#     var.condfwdip,
#   ]
# }

## Create AD Management server
resource "aws_instance" "admgmt" {
    ami                    = "ami-0df583d5f9d8e6cda"
    instance_type          = "t2.micro"
    key_name               =  "0922RDP"
    subnet_id              = data.aws_subnet.westwebsub[0].id
    vpc_security_group_ids = data.aws_security_groups.admgmt.ids
    tags = {
      "Name"        = "admgmt"
      "Description" = "Managed by terraform.io"
    }

    user_data = <<EOF
    <powershell>
    Add-Computer -DomainName ${var.domain_name} -NewName "admgmt" -Credential (New-Object -TypeName PSCredential -ArgumentList "administrator",(ConvertTo-SecureString -String ${var.domain_password} -AsPlainText -Force)[0]) -Restart
    </powershell>
    EOF
}

# resource "aws_eip" "lb" {
#   instance = aws_instance.admgmt.id
#   vpc      = true
# }

# resource "aws_instance" "pwdmgmt01" {
#     count                  = var.environment == "stamps01qa99" ? 1 : 0
#     ami                    = "ami-0b7c10374cfb013e6"
#     instance_type          = "m5.large"
#     key_name               =  "Stamps-AWS-KP"
#     subnet_id              = data.aws_ssm_parameter.private_subnet.value
#     vpc_security_group_ids = data.aws_security_groups.pwdmgmt[0].ids


#     tags = {
#       "Name"        = "pwdmgmt01"
#       "Description" = "Managed by terraform.io"
#     }

#     user_data = <<EOF
#     <powershell>
#     Add-Computer -DomainName ${var.domain_name} -NewName "pwdmgmt01" -Credential (New-Object -TypeName PSCredential -ArgumentList "admin",(ConvertTo-SecureString -String ${var.domain_password} -AsPlainText -Force)[0]) -Restart
#     </powershell>
#     EOF
# }

# resource "aws_directory_service_conditional_forwarder" "aws_local" {
#   directory_id        = aws_directory_service_directory.a1.id
#   remote_domain_name  = "aws.local"

#   dns_ips = [
#     "10.159.49.28",
#     "10.159.75.138",
#   ]
# }


# resource "aws_directory_service_conditional_forwarder" "efs_uswest1_amazonaws_com" {
#   directory_id        = aws_directory_service_directory.sdc.id
#   remote_domain_name  = "efs.us-west-1.amazonaws.com"

#   dns_ips = [
#     var.condfwdip,
#   ]
# }

# resource "aws_directory_service_conditional_forwarder" "corp_stamps_com" {
#   directory_id        = aws_directory_service_directory.sdc.id
#   remote_domain_name  = "corp.stamps.com"

#   dns_ips = [
#     "10.159.49.28",
#     "10.159.75.138"
#   ]
# }


