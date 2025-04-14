resource "aws_security_group" "nginx" {
  name        = "nginx"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "nginx"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4_443_nginx" {
  security_group_id = aws_security_group.nginx.id
  cidr_ipv4         = var.myIP
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4_80_nginx" {
  security_group_id = aws_security_group.nginx.id
  cidr_ipv4         = var.myIP
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4_22_nginx" {
  security_group_id = aws_security_group.nginx.id
  cidr_ipv4         = var.myIP
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_nginx" {
  security_group_id = aws_security_group.nginx.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6_nginx" {
  security_group_id = aws_security_group.nginx.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

// SG-Nginx	Allow HTTP (80), HTTPS (443), SSH (22) from anywhere.