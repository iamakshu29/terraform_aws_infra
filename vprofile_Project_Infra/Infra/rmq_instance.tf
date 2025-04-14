resource "aws_instance" "rmq_instance" {
  ami               = var.amiID
  instance_type     = "t2.micro"
  key_name          = aws_key_pair.terr_rev.key_name
  security_groups   = [aws_security_group.rmq.name]
  availability_zone = "us-east-1a"

  tags = {
    Name        = "rmq_instance"
    Type        = "target"
    Environment = "production"
    Role        = "webserver"
    ManagedBy   = "Terraform"
  }
}
