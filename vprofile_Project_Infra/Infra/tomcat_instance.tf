resource "aws_instance" "tomcat_instance" {
  ami               = var.amiID
  instance_type     = "t2.micro"
  key_name          = aws_key_pair.terr_rev.key_name
  security_groups   = [aws_security_group.tomcat.name]
  availability_zone = "us-east-1a"

  tags = {
    Name        = "tomcat_instance"
    Type        = "target"
    Environment = "production"
    Role        = "webserver"
    ManagedBy   = "Terraform"
    UsedFor     = "Nginx_Reverse_Proxy"
  }
}
