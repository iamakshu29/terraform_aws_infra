resource "aws_instance" "nginx_instance" {
  ami               = var.amiID
  instance_type     = "t2.micro"
  key_name          = aws_key_pair.terr_rev.key_name
  security_groups   = [aws_security_group.nginx.name]
  availability_zone = "us-east-1a"

  tags = {
    Name        = "nginx_instance"
    Type        = "target"
    Environment = "production"
    Role        = "webserver"
    ManagedBy   = "Terraform"
  }
}
