resource "aws_ebs_volume" "mysql_ebs" {
  availability_zone = "us-east-1a"
  size              = 2
}

resource "aws_volume_attachment" "mysql_ebs_attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.mysql_ebs.id
  instance_id = aws_instance.mysql_instance.id
}
