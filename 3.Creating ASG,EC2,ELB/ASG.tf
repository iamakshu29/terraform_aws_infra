resource "aws_launch_template" "ec2_asG_launch_template" {
  name_prefix          = "ec2_asG_launch_template"
  image_id             = data.aws_ami.amiID.id
  instance_type        = "t2.micro"
  key_name             = aws_key_pair.elb_key.key_name
  security_group_names = [aws_security_group.ec2_sg.name]
  provider             = aws
}

resource "aws_autoscaling_group" "ec2_asG" {
  name               = "ec2_asG"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  desired_capacity   = 2
  max_size           = 5
  min_size           = 2

  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true

  launch_template {
    id      = aws_launch_template.ec2_asG_launch_template.id
    version = "$Latest"
  }
}