resource "aws_instance" "web" {
  ami               = data.aws_ami.amiID.id
  instance_type     = "t2.micro"
  provider          = aws
  key_name          = aws_key_pair.terraform_key_pair.key_name
  security_groups   = [aws_security_group.terraform-SG.name]
  availability_zone = "us-east-1a"

  tags = {
    Name = "my-ec2-server_terrraform"
  }
}
