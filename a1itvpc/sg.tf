## SG for admgmt
resource "aws_security_group" "admgmt" {
  name        = "a1-admgmt-sg"
  description = "SG for use with admgmt"
  vpc_id      = aws_vpc.v21qw1.id
  tags = {
    Owner = "terraform.io"
    Name  = "a1-admgmt-sg"
  }
}

variable "admgmt_ingress_ports" {
  description = "Allowed ports on admgmt"
  default     = {
    "445"  = ["10.0.0.0/8"]
    "3389" = ["10.64.0.0/16","47.232.152.136/32"]
    "22"   = ["10.64.0.0/16","47.232.152.136/32"]
  
  }
}

resource "aws_security_group_rule" "admgmt_allow" {
  for_each          = var.admgmt_ingress_ports
  type              = "ingress"
  from_port         = each.key
  to_port           = each.key
  protocol          = "tcp"
  cidr_blocks       = each.value
  security_group_id = aws_security_group.admgmt.id
}

resource "aws_security_group_rule" "admgmt_outbound_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.admgmt.id
}

resource "aws_security_group_rule" "admgmt_allow_icmp" {
  type              = "ingress"
  from_port         = "-1"
  to_port           = "-1"
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.admgmt.id
}


## Rule for directory service

# resource "aws_security_group_rule" "dns_outbound_udp" {
#   type              = "egress"
#   from_port         = 53
#   to_port           = 53
#   protocol          = "udp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_directory_service_directory.a1.security_group_id
# }

# resource "aws_security_group_rule" "dns_outbound_tcp" {
#   type              = "egress"
#   from_port         = 53
#   to_port           = 53
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_directory_service_directory.a1.security_group_id
# }

# resource "aws_security_group_rule" "ad_trust_outbound" {
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_directory_service_directory.a1.security_group_id
# }