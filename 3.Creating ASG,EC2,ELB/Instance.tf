resource "aws_instance" "web" {
  ami               = data.aws_ami.amiID.id
  instance_type     = "t2.micro"
  key_name          = aws_key_pair.elb_key.key_name
  security_groups   = [aws_security_group.ec2_sg.name]
  availability_zone = "us-east-1a"

  tags = {
    Name = "my-ec2-server_terrraform"
  }
}
