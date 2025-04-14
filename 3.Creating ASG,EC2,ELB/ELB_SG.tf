resource "aws_security_group" "elb_sg" {
  name        = "elb_sg"
  description = "Allow at 22 and 80 in inbound traffic and all outbound traffic"
  vpc_id = data.aws_vpc.default.id

  tags = {
    Name = "allow_22_80_elb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_22_ingress" {
  security_group_id = aws_security_group.elb_sg.id
  cidr_ipv4         = var.myip
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_80_ingress" {
  security_group_id = aws_security_group.elb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.elb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.elb_sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}