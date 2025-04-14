resource "aws_security_group" "mysql" {
  name        = "mysql"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "mysql"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4_443_mysql" {
  for_each = {
    tomcat = aws_security_group.tomcat.id
    rmq    = aws_security_group.rmq.id
  }
  security_group_id = aws_security_group.mysql.id
  referenced_security_group_id = each.value
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306

  depends_on = [aws_security_group.tomcat,aws_security_group.rmq]
}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4_22_mysql" {
  security_group_id = aws_security_group.mysql.id
  cidr_ipv4         = var.myIP
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_mysql" {
  security_group_id = aws_security_group.mysql.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6_mysql" {
  security_group_id = aws_security_group.mysql.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

// SG-mysql	Allow 3306 from Tomcat/RabbitMQ only, SSH (22) from trusted IPs.