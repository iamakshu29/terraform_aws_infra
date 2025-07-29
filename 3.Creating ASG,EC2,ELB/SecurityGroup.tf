resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow at 22 and 80 in inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.default_id.id
  tags = {
    Name = "allow_22_80_ec2"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_22_ingress_ec2" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = var.myip
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_80_ingress_ec2" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_80_ingress_ec2_elb" {
  security_group_id = aws_security_group.ec2_sg.id
  referenced_security_group_id  = aws_security_group.elb_sg.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

  depends_on = [aws_security_group.elb_sg]
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_ec2" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6_ec2" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}