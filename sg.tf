resource "aws_security_group_rule" "dns_outbound_udp" {
  type              = "egress"
  from_port         = 53
  to_port           = 53
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_directory_service_directory.a1.security_group_id
}

resource "aws_security_group_rule" "dns_outbound_tcp" {
  type              = "egress"
  from_port         = 53
  to_port           = 53
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_directory_service_directory.a1.security_group_id
}

resource "aws_security_group_rule" "ad_trust_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_directory_service_directory.a1.security_group_id
}