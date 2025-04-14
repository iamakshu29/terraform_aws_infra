resource "aws_security_group" "rmq" {
  name        = "rmq"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "rmq"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4_5672_rmq" {
  security_group_id = aws_security_group.rmq.id
  referenced_security_group_id = aws_security_group.tomcat.id
  from_port         = 5672
  ip_protocol       = "tcp"
  to_port           = 5672

  depends_on = [aws_security_group.tomcat]
}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4_15672_rmq" {
  security_group_id = aws_security_group.rmq.id
  referenced_security_group_id = aws_security_group.tomcat.id
  from_port         = 15672
  ip_protocol       = "tcp"
  to_port           = 15672

  depends_on = [aws_security_group.tomcat]
}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4_22_rmq" {
  security_group_id = aws_security_group.rmq.id
  cidr_ipv4         = var.myIP
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_rmq" {
  security_group_id = aws_security_group.rmq.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6_rmq" {
  security_group_id = aws_security_group.rmq.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

// SG-RMQ Allow 5672 (AMQP) and 15672 (management UI) from Tomcat, SSH (22) from trusted IPs.