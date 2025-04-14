resource "aws_security_group" "tomcat" {
  name        = "tomcat"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "tomcat"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4_8080_tomcat" {
  security_group_id = aws_security_group.tomcat.id
  referenced_security_group_id = aws_security_group.nginx.id
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080

  depends_on = [aws_security_group.nginx]
}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4_22_tomcat" {
  security_group_id = aws_security_group.tomcat.id
  cidr_ipv4         = var.myIP
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_tomcat" {
  security_group_id = aws_security_group.tomcat.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6_tomcat" {
  security_group_id = aws_security_group.tomcat.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

// SG-tomcat Allow 8080 (for web apps) from Nginx only, SSH (22) from trusted IPs.