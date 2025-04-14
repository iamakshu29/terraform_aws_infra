# memcache Instance
resource "aws_instance" "memcache_instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.terr_rev.key_name
  security_groups   = [aws_security_group.memcache.name]
  availability_zone = "us-east-1a"

  tags = {
    Name = "memcache_instance"
  }
}

#rmq Instance
resource "aws_instance" "rmq_instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.terr_rev.key_name
  security_groups   = [aws_security_group.rmq.name]
  availability_zone = "us-east-1a"

  tags = {
    Name = "rmq_instance"
  }
}

#tomcat Instance
resource "aws_instance" "tomcat_instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.terr_rev.key_name
  security_groups   = [aws_security_group.tomcat.name]
  availability_zone = "us-east-1a"

  tags = {
    Name = "tomcat_instance"
  }
}

#nginx Instance
resource "aws_instance" "nginx_instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.terr_rev.key_name
  security_groups   = [aws_security_group.nginx.name]
  availability_zone = "us-east-1a"

  tags = {
    Name = "nginx_instance"
  }
}

#mysql Instance
resource "aws_instance" "mysql_instance" {
  ami = data.aws_ami.amzn_linux_2.id
  instance_type = var.instance_type
  key_name = aws_key_pair.terr_rev.key_name
  security_groups   = [aws_security_group.mysql.name]
  availability_zone = "us-east-1a"

  tags = {
    Name = "mysql_instance"
  }
}