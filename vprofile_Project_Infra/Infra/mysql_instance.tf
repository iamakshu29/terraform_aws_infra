resource "aws_instance" "mysql_instance" {
  ami               = var.amiID
  instance_type     = "t2.micro"
  key_name          = aws_key_pair.terr_rev.key_name
  security_groups   = [aws_security_group.mysql.name]
  availability_zone = "us-east-1a"

  tags = {
    Name        = "mysql_instance"
    Type        = "target"
    Environment = "production"
    Role        = "webserver"
    ManagedBy   = "Terraform"
  }
}
