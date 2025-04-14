# memcache Security Group
resource "aws_security_group" "memcache" {
  name        = "memcache"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "memcache"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4_5672_memcache" {
  security_group_id = aws_security_group.memcache.id
  referenced_security_group_id = aws_security_group.tomcat.id
  from_port         = 5672
  ip_protocol       = "tcp"
  to_port           = 5672
}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4_11211_memcache" {
  for_each = {
    tomcat = aws_security_group.tomcat.id
    rmq    = aws_security_group.rmq.id
  }
  security_group_id = aws_security_group.memcache.id
  referenced_security_group_id = each.value
  from_port         = 11211
  ip_protocol       = "tcp"
  to_port           = 11211

  depends_on = [aws_security_group.tomcat,aws_security_group.rmq]
}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4_22_memcache" {
  security_group_id = aws_security_group.memcache.id
  cidr_ipv4         = var.myIP
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_memcache" {
  security_group_id = aws_security_group.memcache.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6_memcache" {
  security_group_id = aws_security_group.memcache.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

// SG-Memcached	Allow 11211 (Memcached) from Tomcat/RabbitMQ only, SSH (22) from trusted IPs.



# rmq Security Group
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


# tomcat Security Group
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


# nginx Security Group
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

# mysql Security Group
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